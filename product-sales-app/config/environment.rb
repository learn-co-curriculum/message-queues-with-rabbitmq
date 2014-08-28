ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require_all 'app'
require_all 'config/initializers'

Product.destroy_all if ENV['SINATRA_ENV'] == 'test'
