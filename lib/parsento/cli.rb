# frozen_string_literal: true

module Parsento
  # Manage command line options
  class CLI
    class << self
      def parse_options(args = ARGV)
        print_and_exit "No command line options defined! #{colorize('Use --help')} for getting help." if args.empty?
      end

      def run(opts)

      end

      private

      def print_and_exit(text)
        $stdout.puts(text)
        Kernel.exit
      end

      def colorize(text)
        "\e[1m#{text}\e[0m"
      end
    end
  end
end
