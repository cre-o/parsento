# frozen_string_literal: true

module Parsento
  # Manage command line options
  class CLI
    class << self
      def parse_options(args = ARGV)
        print_and_exit "No command line options defined! #{colorize('Use --help')} for getting help." if args.empty?

        begin
          raise Parsento::CLIOptionsError unless file_path_defined?(args) && valid_args(args)

          print_and_exit(help_text) if help_needed? # Display help
        rescue Parsento::CLIOptionsError
          print_and_exit help_text
        rescue Parsento::InvalidOptionError => e
          print_and_exit "Invalid option #{e.option.inspect}"
        end
      end

      def run(opts)

      end

      private

      def print_and_exit(text)
        $stdout.puts(text)
        Kernel.exit
      end

      def help_needed?
        @valid_args.include?('-h') || @valid_args.include?('--help')
      end

      def valid_args(args)
        args = args[0..-2] if file_path_defined?(args)
        @valid_args ||= args.map do |arg|
          known_options.include?(arg) ? arg : raise(Parsento::InvalidOptionError.new(arg))
        end.compact
      end

      def file_path_defined?(args)
        File.file?(args.last)
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
