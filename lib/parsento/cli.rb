# frozen_string_literal: true

module Parsento
  # Manage command line options
  class CLI
    class << self
      def parse_options
        display_help

        begin
          raise Parsento::CLIOptionsError unless file_path_defined? && valid_args
        rescue Parsento::CLIOptionsError
          print_and_exit help_text
        rescue Parsento::InvalidOptionError => e
          print_and_exit "Invalid option #{e.option.inspect}"
        end

        {
          file: file_path,
          args: @valid_args
        }
      end

      def run(opts)
        if Parsento.const_defined?('Application')
          Application.start(opts[:file], opts[:args])
        else # Or we can initialize it with injection
          reader = Parsento::Reader.new(opts[:file], opts[:args])
          app = BasicApplication.new(reader)
          app.start
        end
      end

    private

      def print_and_exit(text)
        $stdout.puts(text)
        Kernel.exit
      end

      def display_help
        print_and_exit "No command line options defined! #{colorize('Use --help')} for getting help." if ARGV.empty?
        print_and_exit(help_text) if help_needed?
      end

      def help_needed?
        ARGV.include?('-h') || ARGV.include?('--help')
      end

      def valid_args
        args = file_path_defined? ? ARGV[0..-2] : ARGV
        @valid_args ||= args.map do |arg|
          known_options.include?(arg) ? arg : raise(Parsento::InvalidOptionError.new(arg), nil)
        end.compact
      end

      def file_path_defined?
        File.file?(ARGV.last)
      end

      def file_path
        ARGV.last
      end

      def help_text
        <<-TEXT
        #
        ## This is a log parser program which is receives a log as argument and
        ## returns sorted list and some additional features as a final result
        #
        #{colorize('Usage: ./bin/parsento [options] [file_path]*')}

        -h, --help  Show this help message.
        TEXT
      end

      def colorize(text)
        "\e[1m#{text}\e[0m"
      end

      def known_options
        %w[-h --help]
      end
    end
  end
end
