ENV['SINATRA_ENV'] = 'test'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require 'capybara/rspec'
require 'capybara/dsl'

Capybara.default_driver = :webkit

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before do
    visit('http://localhost:9292/database_cleaner')
    sleep 0.5
    visit('http://localhost:9293/database_cleaner')
  end

  config.before :all do
    stop
    reset
    start
  end

  config.after :all do
    stop
  end
end

def stop
  `bin/stop`
end

def reset
  `bin/reset`
end

def start
  `bin/start`
end
