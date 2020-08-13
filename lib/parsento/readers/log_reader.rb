# frozen_string_literal: true
require_relative 'strategies/log_strategy'

module Parsento
  # Extends knowledge about available readers
  class LogReader
    attr_reader :file_path, :options

    def initialize(file_path, options)
      @file_path = file_path
      @options = options
    end

    def read
      #... if options has an option "how to build" or display default strategy...
      LogStrategy.sort_by_page_views self
      LogStrategy.display_separator self
      LogStrategy.sort_by_unique_page_views self
    end
  end
end
