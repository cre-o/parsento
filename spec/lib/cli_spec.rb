# frozen_string_literal: true

require 'rspec_helper'

describe Parsento::CLI do
  it '.parse_options' do
    expect(described_class.respond_to?(:parse_options)).to be_truthy
  end

  it '.run' do
    expect(described_class.respond_to?(:run)).to be_truthy
  end
end
