# frozen_string_literal: true

module Parsento
  # Extends knowledge about available readers
  module LogStrategy
    def self.sort_by_page_views(reader)
      calculator = Calculate.new(reader.file_path)
      calculator.calculate_with(/^\/.*\s[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$/, reader.options)

      Render.new(calculator.calc_views).sorted_views
    end

    def self.display_separator(reader)
      print "\n\e[1m#{reader.options[:lists_separator]}\e[0m\n\n"
    end

    def self.sort_by_unique_page_views(reader)
      calculator = Calculate.new(reader.file_path)
      calculator.calculate_with(/^\/.*\s[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$/, reader.options)

      Render.new(calculator.calc_uniq_visitors).sorted_unique_views
    end

    class Calculate
      attr_reader :calculations

      def initialize(file_path)
        @file_path = file_path
        @calculations = nil
      end

      def calculate_with(regexp, options)
        @calculations = IO.foreach(@file_path).lazy.grep(regexp).take(options[:max_lines]).to_a
      end

      def calc_views(return_hash = {})
        @calculations.each do |v|
          spltd = v.split
          page  = spltd.first
          return_hash.key?(page) ? return_hash[page][:visits] += 1 : return_hash[page] = {visits: 1}
        end
        return_hash
      end

      def calc_uniq_visitors(return_hash = {})
        @calculations.each do |v|
          spltd = v.split
          page  = spltd.first
          ip    = spltd.last
          if return_hash.key?(page)
            unless return_hash[page][:unique_ips].include?(ip)
              return_hash[page][:unique_ips].push(ip)
              return_hash[page][:unique_ips_count] += 1
            end
          else # db hash not exists for this page, create it!
            return_hash[page] = {unique_ips: [ip], unique_ips_count: 1}
          end
        end
        return_hash
      end
    end

    class Render
      def initialize(data)
        @data = data
      end

      def sorted_views
        sort_by(:visits).each { |a| print "#{a[0]} #{a[1][:visits]} visits\n" }
      end

      def sorted_unique_views
        sort_by(:unique_ips_count).each { |a| print "#{a[0]} #{a[1][:unique_ips_count]} unique views\n" }
      end

    private

      def sort_by(type)
        @data.sort { |a, b| b[1][type.to_sym] <=> a[1][type.to_sym] }
      end
    end
  end
end
