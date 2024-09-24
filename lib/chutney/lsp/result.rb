# frozen_string_literal: true

module Chutney
  module LSP
    class Result
      attr_reader :id, :response

      def initialize(response:, id: nil)
        @id = id
        @response = response
      end
    end
  end
end
