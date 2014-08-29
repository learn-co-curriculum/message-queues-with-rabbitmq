ENV['SINATRA_ENV'] = 'test'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require 'capybara/rspec'
require 'capybara/dsl'

Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before do
    visit('http://localhost:9292/database_cleaner')
    sleep 0.5
    visit('http://localhost:9293/database_cleaner')
  end

  config.before :all do
    puts '  Flushing rabbitmq and restarting applications...'
    `bin/start_rabbitmq`
    `bin/reset_rabbitmq`
    `bin/restart_apps`
  end

  config.after :all do
    stop
  end
end
