# frozen_string_literal: true

ENV['PARSENTO_ENV'] ||= 'test'

Bundler.require(:default, :test)

RSpec.configure do |config|
  config.fuubar_progress_bar_options = {format: '«Magic» do not touch! <%B> %p%% %a'}
  config.fail_fast = 1
end
