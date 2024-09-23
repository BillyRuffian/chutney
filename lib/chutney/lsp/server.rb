module Chutney
  module LSP
    class Server
      LSP_CONST = LanguageServer::Protocol::Constant
      LSP_IO = LanguageServer::Protocol::Transport::Stdio
      LSP_IF = LanguageServer::Protocol::Interface
      LOG = Logger.new('/tmp/chutney-lsp.log')

      def initialize
        @writer = LSP_IO::Writer.new
        @reader = LSP_IO::Reader.new
        @mutex = Mutex.new
        @incoming_queue = Thread::Queue.new
        @outgoing_queue = Thread::Queue.new

        @dispatcher = Thread.new do
          while (message = @outgoing_queue.pop)
            LOG.debug { "Response: #{message.to_json}" }
            if message.is_a? Result
              LOG.debug { 'Dispatching (Result) ------>' }
              @mutex.synchronize { @writer.write(id: message.id, result: message.response) }
              LOG.debug { 'Dispatching (Result) <------' }
            else
              @mutex.synchronize do
                LOG.debug { 'Dispatching ------>' }
                @writer.write(message.to_hash)
                LOG.debug { 'Dispatching <------' }
              rescue StandardError => e
                LOG.warn { "Exception: #{e.message} #{e.backtrace}" }
              end
            end
          end
        end
        @worker = Thread.new do
          while (message = @incoming_queue.pop)
            LOG.debug { 'Dequeuing ------>' }
            process_message(message)
            LOG.debug { 'Dequeuing <------' }
          end
        end

        Thread.main.priority = 1
      end

      def process_message(message)
        case message[:method]
        when 'initialize'
          run_initialize(message)
        when 'initialized'
          run_initialized
        when 'textDocument/didOpen', 'textDocument/didSave'
          run_did_change(message)
        when 'textDocument/didClose'
          run_did_close
        end
      end

      def send_message(message)
        return if outgoing_queue.closed?

        outgoing_queue << message
      end

      def send_log(text)
      end

      def send_notification(message)
        notification = LSP_IF::NotificationMessage.new(
          method: 'window/showMessage',
          jsonrpc: '2.0',
          params: LSP_IF::ShowMessageParams.new(
            type: LSP_CONST::MessageType::INFO,
            message:
          )
        )
        send_message(notification)
      end

      def run_initialize(message)
        initialize_result = LSP_IF::InitializeResult.new(
          capabilities: LSP_IF::ServerCapabilities.new(document_formatting_provider: true,
                                                       text_document_sync: LSP_IF::TextDocumentSyncOptions.new(change: LSP_CONST::TextDocumentSyncKind::FULL,
                                                                                                               open_close: true,
                                                                                                               save: true)),
          server_info: {
            name: 'chutney-lsp',
            version: VERSION
          }
        )
        send_message(Result.new(id: message[:id], response: initialize_result))
      end

      def run_initialized
        RubyVM::YJIT.enable if defined?(RubyVM::YJIT.enable)
        send_notification('Chutney LSP Server up and running')
      end

      def run_did_change(message)
        document = message.dig(:params, :textDocument)
        filename = document[:uri].delete_prefix('file://')
        linter = Chutney::ChutneyLint.new(*filename)
        offenses = linter.analyse.values.first.filter { |r| r[:issues].any? }
        LOG.debug { "Found #{offenses.count} offenses: #{offenses.to_json}" }
        diagnostics = offenses
                      .flat_map { |group| group[:issues].each { |issue| issue[:linter] = group[:linter] } }
                      .map { |offense| to_diagnostic(offense) }
        send_message(diagnostic_message(document[:uri], diagnostics))
      end

      def diagnostic_message(file_uri, diagnostics)
        # JSON.parse(<<~XXX)
        #   {"jsonrpc":"2.0","method":"textDocument/publishDiagnostics","params":{"diagnostics":[{"code":"Style/DoubleNegation","message":"Avoid the use of double negation (`!!`).","range":{"end":{"character":1,"line":0},"start":{"character":0,"line":0}},"severity":3,"source":"rubocop"},{"code":"Style/FrozenStringLiteralComment","message":"Missing frozen string literal comment.","range":{"end":{"character":1,"line":0},"start":{"character":0,"line":0}},"severity":3,"source":"rubocop"},{"code":"Layout/SpaceAfterNot","message":"Do not leave space between `!` and its argument.","range":{"end":{"character":7,"line":0},"start":{"character":1,"line":0}},"severity":3,"source":"rubocop"},{"code":"Lint/LiteralAsCondition","message":"Literal `true` appeared as a condition.","range":{"end":{"character":7,"line":0},"start":{"character":3,"line":0}},"severity":2,"source":"rubocop"},{"code":"Layout/TrailingEmptyLines","message":"Final newline missing.","range":{"end":{"character":7,"line":0},"start":{"character":7,"line":0}},"severity":3,"source":"rubocop"}],"uri":"file:///Users/brooken/Projects/NBT/chutney/examples/emoji.feature"}}
        # XXX
        {
          method: 'textDocument/publishDiagnostics',
          params: {
            uri: file_uri,
            diagnostics:
          }
        }
      end

      def to_diagnostic(offense)
        code = offense[:linter]
        message = offense[:message]
        source = 'chutney'
        { code:, message:, source:, severity: 1, range: to_range(offense[:location]) }
      end

      def to_range(location)
        {
          start: { character: location.fetch(:column, 1) - 1, line: location.fetch(:line, 1) - 1 },
          end: { character: 0, line: location.fetch(:line, 1) }
        }
      end

      def did_close
      end

      def shutdown
        incoming_queue.clear
        outgoing_queue.clear
        incoming_queue.close
        outgoing_queue.close
        worker.join
        dispatcher.join
      end

      def start
        LOG.debug { 'started' }
        reader.read do |message|
          LOG.debug { "request received -------> : #{message.to_json}" }
          method = message[:method]

          case method
          when 'initialize', 'initialized', 'textDocument/didOpen', 'textDocument/didClose', 'textDocument/didSave'
            incoming_queue.push(message)
          when 'shutdown'
            shutdown
          when 'exit'
            mutex.synchronize do
              status = incoming_queue.closed? ? 0 : 1
              exit(status)
            end
          end

          LOG.debug { 'request received <-------' }
        end

        LOG.debug { 'FINISHED started' }
      end

      private

      attr_reader :reader, :writer, :mutex, :incoming_queue, :outgoing_queue, :worker, :dispatcher
    end
  end
end
