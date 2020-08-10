# frozen_string_literal: true

module Parsento
  # Manage command line options
  class CLI
    class << self
      def parse_options(args = ARGV)
        print_and_exit 'No command line options defined!' if args.empty?
      end

      def run(opts)

      end

      private

      def print_and_exit(text)
        $stdout.puts(text)
        Kernel.exit
      end
    end
  end
end
