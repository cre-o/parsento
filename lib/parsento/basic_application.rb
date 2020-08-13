# frozen_string_literal: true

module Parsento
  # Basic application logic (with possibility to extend)
  class BasicApplication
    def initialize(reader)
      # @TODO make validation
      @reader = reader
      @reader_options = {
        production: {max_lines: 500, lists_separator: ''},
        development: {max_lines: 1000, lists_separator: ''},
        test: {max_lines: 500, lists_separator: ''}
      }
    end

    def start
      @reader.parse with_options
    end

  protected

    def current_env
      (ENV['PARSENTO_ENV'] || 'development').to_sym
    end

    def with_options
      @reader_options.key?(current_env) ? @reader_options[current_env] : @reader_options[:development]
    end
  end
end
