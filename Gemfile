# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.7.1'

group :development do
  gem 'guard-rspec', require: false # Rspec rerun when some specs have changes
  gem 'guard-rubocop', require: false
  gem 'pry', '~> 0.12.2' # Better debugging
  # What about "Code smells"?
  gem 'reek', require: false
  gem 'rubocop', require: false
  gem 'simplecov', require: false
end

group :test do
  # Rspec libraries
  %w[rspec-core rspec-expectations rspec-mocks rspec-support].each do |lib|
    gem lib
  end
  # and nice specs loading bar
  gem 'fuubar', '~> 2.5.0'
end
