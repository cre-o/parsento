# frozen_string_literal: true

require 'rspec_helper'

describe Parsento::BasicApplication do
  let(:valid_file_path) { source_fixture('example.log') }
  let(:reader) { Parsento::Reader.new({file: valid_file_path}) }

  subject { Parsento::BasicApplication.new(reader) }

  it { is_expected.to respond_to(:start) }

  it '.start' do
    expect(described_class.respond_to?(:start)).to be_truthy
  end
end
