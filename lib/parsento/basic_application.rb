# frozen_string_literal: true

module Parsento
  # Basic application logic (with possibility to extend)
  class BasicApplication
    def initialize(reader)
      # @TODO make validation
      @reader = reader
    end

    # @TODO pass additional options to the parser
    def start
      @reader.parse
    end

    class << self
      def start(file_to_read, file_type = :log)
        new(Parsento::Reader.new(file_to_read, file_type)).start
      end
    end
  end
end
