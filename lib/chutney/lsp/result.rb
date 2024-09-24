# frozen_string_literal: true

module Chutney
  module LSP
    # A wrapper that holds a response to the query message
    # from the LSP client
    class Result
      attr_reader :id, :response

      def initialize(response:, id: nil)
        @id = id
        @response = response
      end
    end
  end
end
