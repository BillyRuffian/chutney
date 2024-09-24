# frozen_string_literal: true

module Chutney
  module LSP
    # A minimalistic language server which will lint gherkin
    # files on open and save
    class Server
      LSP_CONST = LanguageServer::Protocol::Constant
      LSP_IO = LanguageServer::Protocol::Transport::Stdio
      LSP_IF = LanguageServer::Protocol::Interface

      def initialize
        @writer = LSP_IO::Writer.new
        @reader = LSP_IO::Reader.new
        @mutex = Mutex.new
        @incoming_queue = Thread::Queue.new
        @outgoing_queue = Thread::Queue.new

        @dispatcher = Thread.new do
          while (message = @outgoing_queue.pop)
            if message.is_a? Result
              @mutex.synchronize { @writer.write(id: message.id, result: message.response) }
            else
              @mutex.synchronize { @writer.write(message.to_hash) }
            end
          end
        end

        @worker = Thread.new do
          while (message = @incoming_queue.pop)
            process_message(message)
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
          # no-op
        end
      end

      def send_message(message)
        return if outgoing_queue.closed?

        outgoing_queue << message
      end

      def send_log(message, method: 'window/logMessage', error: false)
        type = error ? LSP_CONST::MessageType::ERROR : LSP_CONST::MessageType::INFO
        notification = LSP_IF::NotificationMessage.new(
          method:,
          jsonrpc: '2.0',
          params: LSP_IF::ShowMessageParams.new(
            type:,
            message: "Chutney LSP [#{VERSION}]: #{message}"
          )
        )
        send_message(notification)
      end

      def send_notification(message, error: false)
        send_log(message, method: 'window/showMessage', error:)
      end

      def run_initialize(message)
        initialize_result = LSP_IF::InitializeResult.new(
          capabilities: LSP_IF::ServerCapabilities.new(
            document_formatting_provider: true,
            text_document_sync: LSP_IF::TextDocumentSyncOptions.new(
              change: LSP_CONST::TextDocumentSyncKind::FULL,
              open_close: true,
              save: true
            )
          ),
          server_info: {
            name: 'chutney-lsp',
            version: VERSION
          }
        )
        send_message(Result.new(id: message[:id], response: initialize_result))
        send_log('Initializing')
      end

      def run_initialized
        RubyVM::YJIT.enable if defined?(RubyVM::YJIT.enable)
        send_notification('Chutney LSP Server up and running')
        send_log('Initialized')
      end

      def run_did_change(message)
        document = message.dig(:params, :textDocument)
        filename = document[:uri].delete_prefix('file://')
        send_log("Evaluating #{filename}")
        linter = Chutney::ChutneyLint.new(*filename)
        linter.configuration.quiet!
        begin
          offenses = linter.analyse.values.first.filter { |r| r[:issues].any? }
        rescue StandardError => e
          send_log("Could not parse #{filename} as Gherkin. Received: #{e.full_message}", error: true)
          send_notification("Could not parse #{filename} as Gherkin.", error: true)
          return
        end
        send_log("Found #{offenses.count} offenses")
        diagnostics = offenses
                      .flat_map { |group| group[:issues].each { |issue| issue[:linter] = group[:linter] } }
                      .map { |offense| to_diagnostic(offense) }
        send_message(diagnostic_message(document[:uri], diagnostics))
      end

      def diagnostic_message(file_uri, diagnostics)
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

      def shutdown
        incoming_queue.clear
        outgoing_queue.clear
        incoming_queue.close
        outgoing_queue.close
        worker.join
        dispatcher.join
        send_log('Shutdown complete')
      end

      def start
        reader.read do |message|
          method = message[:method]
          send_log("Received #{method}")

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
        end
      end

      private

      attr_reader :reader, :writer, :mutex, :incoming_queue, :outgoing_queue, :worker, :dispatcher
    end
  end
end
