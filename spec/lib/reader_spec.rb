# frozen_string_literal: true

require 'rspec_helper'

describe Parsento::Reader do
  let(:valid_file_path) { source_fixture('example.log') }
  let(:parser_options) { {max_lines: 1000, lists_separator: ''} }
  subject { described_class.new({file: valid_file_path}) }

  it { is_expected.to respond_to(:parse) }

  context 'Error-prone' do
    let(:unsupported_file_ext) { source_fixture('example.xml') }
    let(:invalid_file_path) { '/totally/incorrect/file/path' }

    it 'Raises a "Correct reader engine was not found" error on #parse' do
      expect { described_class.new({file: unsupported_file_ext}).parse(parser_options) }.to raise_error(Parsento::ValidationError, 'Correct reader engine for selected .xml file was not found.')
    end

    it 'Raises an "Invalid file path" error' do
      expect { described_class.new({file: invalid_file_path}) }.to raise_error(Parsento::ValidationError, 'Invalid file path')
    end
  end
end
