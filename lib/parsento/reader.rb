# frozen_string_literal: true

# Require all readers
Dir[File.join(__dir__, 'readers', '*_reader.rb')].sort.each { |file| require file }

module Parsento
  # Reading logic for the input file
  class Reader
    # @TODO create XML reader
    attr_reader :options

    def initialize(options)
      @file_path = options[:file]
      @args      = options[:args]

      run_validations
    end

    # By default (and for simplicity) only one parser engine is configured
    # Other engines can be connected at the top of current class and called here by file extension
    def parse(parser_options)
      if file_ext == '.log'
        log_reader = LogReader.new(@file_path, parser_options)
        log_reader.read
      else
        raise Parsento::ValidationError, "Correct reader engine for selected #{file_ext} file was not found."
      end
    end

  private

    def run_validations
      validate_file_path && validate_options
    end

    def validate_file_path
      raise Parsento::ValidationError, 'Invalid file path' unless File.file?(@file_path)
    end

    # No options in this version
    def validate_options; end

    def file_ext
      File.extname(@file_path)
    end
  end
end
