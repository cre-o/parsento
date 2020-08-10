# frozen_string_literal: true

module Parsento
  # Extends knowledge about available readers
  module Readers
    # Reads .log files
    module Log
      def parse(file_path, options)
        regexp = /^\/.*\s[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$/
        raw_array = IO.foreach(file_path).lazy.grep(regexp).take(options[:max_lines]).to_a
        pages_h = store_in_hash(raw_array)

        print_stats(pages_h, options)
      end

    private

      def print_stats(pages_h, options)
        sort_by(pages_h, :visits).each { |a| print "#{a[0]} #{a[1][:visits]} visits\n" }
        print "\n\e[1m#{options[:lists_separator]}\e[0m\n\n"
        sort_by(pages_h, :unique_ips_count).each { |a| print "#{a[0]} #{a[1][:unique_ips_count]} unique views\n" }
      end

      def store_in_hash(raw_array, pages_h = {})
        raw_array.each do |v|
          spltd = v.split
          page  = spltd.first
          ip    = spltd.last

          if pages_h.key?(page)
            pages_h[page][:visits] += 1
            unless pages_h[page][:unique_ips].include?(ip)
              pages_h[page][:unique_ips].push(ip)
              pages_h[page][:unique_ips_count] += 1
            end
          else # db hash not exists for this page, create it!
            pages_h[page] = {visits: 1, unique_ips: [ip], unique_ips_count: 1}
          end
        end

        pages_h
      end

      def sort_by(pages_h, type)
        pages_h.sort { |s1, s2| s2[1][type.to_sym] <=> s1[1][type.to_sym] }
      end
    end
  end
end
