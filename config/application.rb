# frozen_string_literal: true

# @TODO create new GEM
require_relative '../lib/parsento'

Bundler.require(:default, :development)

module Parsento
  # Extended Application, configured with the current ENV
  class Application < Parsento::BasicApplication
    def initialize(reader)
      super
      @reader_options = {
        production: {max_lines: 1000, lists_separator: '(ﾉ◕ヮ◕)ﾉ*:・ﾟ✧'},
        development: {max_lines: 3000, lists_separator: '¯\_(ツ)_/¯'},
        test: {max_lines: 1000, lists_separator: '•ᴗ•'}
      }
    end
  end
end
