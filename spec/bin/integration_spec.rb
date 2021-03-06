# frozen_string_literal: true

require 'open3'
require 'helper_methods'

describe 'Application integration testing' do
  let(:valid_file_path) { source_fixture('example.log') }
  let(:invalid_file_path) { '/!/location/not/valid' }
  let(:env_flag) { 'PARSENTO_ENV=test' }

  before(:each) { @cmd_out = nil }

  context 'Displays actual result' do
    it 'For page visits' do
      Open3.popen2("#{env_flag} ./bin/parsento #{valid_file_path}") { |_i, o, _t| @cmd_out = o.gets(nil) }
      expect(@cmd_out).to include('/about/2 90 visits')
      expect(@cmd_out).to include("/home 78 visits\n\n") # Which means it is the last record
    end

    it 'For unique views' do
      Open3.popen2("#{env_flag} ./bin/parsento #{valid_file_path}") { |_i, o, _t| @cmd_out = o.gets(nil) }
      expect(@cmd_out).to include('/help_page/1 23 unique views')
      expect(@cmd_out).to include("/about 21 unique views\n")
    end

    it 'For •ᴗ•' do
      Open3.popen2("#{env_flag} ./bin/parsento #{valid_file_path}") { |_i, o, _t| @cmd_out = o.gets(nil) }
      expect(@cmd_out).to include('•ᴗ•')
    end
  end

  context 'Shows help message' do
    it 'With "--h" option' do
      Open3.popen2("#{env_flag} ./bin/parsento -h") { |_i, o, _t| @cmd_out = o.gets(nil) }
      expect(@cmd_out).to include('Usage: ./bin/parsento [options] [file_path]*')
    end

    it 'With "--help" option' do
      Open3.popen2("#{env_flag} ./bin/parsento --help") { |_i, o, _t| @cmd_out = o.gets(nil) }
      expect(@cmd_out).to include('Usage: ./bin/parsento [options] [file_path]*')
    end
  end

  context 'Shows human readable error messages' do
    let(:incorrect_option) { '-alxmanjsjc' }

    it 'No command line options defined!' do
      Open3.popen2("#{env_flag} ./bin/parsento") { |_i, o, _t| @cmd_out = o.gets(nil) }
      expect(@cmd_out).to include('No command line options defined!')
    end

    it '"Invalid option" message' do
      Open3.popen2("#{env_flag} ./bin/parsento #{incorrect_option} #{valid_file_path}") { |_i, o, _t| @cmd_out = o.gets(nil) }
      expect(@cmd_out).to include("Invalid option \"#{incorrect_option}\"")
    end

    it 'Displays help if file_path is incorrect' do
      Open3.popen2("#{env_flag} ./bin/parsento #{invalid_file_path}") { |_i, o, _t| @cmd_out = o.gets(nil) }
      expect(@cmd_out).to include('./bin/parsento [options] [file_path]*')
    end
  end
end
