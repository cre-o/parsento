# frozen_string_literal: true

require_relative '../lib/parsento'

Bundler.require(:default, :development)

module Parsento
  # Extended Application, configured with the current ENV
  class Application < Parsento::BasicApplication

  end
end
