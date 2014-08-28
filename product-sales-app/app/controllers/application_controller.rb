module ProductSalesApp
  class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    set :session_secret, "my_application_secret"
    set :views, Proc.new { File.join(root, "../views/") }

    get '/' do
      redirect to('/products')
    end

    get '/database_cleaner' do
      if ENV['SINATRA_ENV'] == 'test'
        puts 'Cleaning database...'
        DatabaseCleaner.strategy = :truncation
        DatabaseCleaner.start
        DatabaseCleaner.clean
        puts 'Done.'
      end

      200
    end
  end
end
