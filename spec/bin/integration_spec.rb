# frozen_string_literal: true

require 'open3'
require 'helper_methods'

describe 'Application integration testing' do
  before(:each) { @cmd_out = nil }

  context 'Shows human readable error messages' do
    it 'No command line options defined!' do
      Open3.popen2("./bin/parsento") { |_i, o, _t| @cmd_out = o.gets(nil) }
      expect(@cmd_out).to include('No command line options defined!')
    end
  end
end
