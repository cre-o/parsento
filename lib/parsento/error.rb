# frozen_string_literal: true

module Parsento
  class Error < StandardError; end
  class CLIOptionsError < Error; end
  class InvalidOptionError < Error
    attr_reader :option

    def initialize(option)
      super
      @option = option
    end
  end
  class ValidationError < Error; end
end
