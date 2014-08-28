module ProductSalesApp
  class ProductsController < ApplicationController
    get '/products' do
      puts 'Product#index action running...'
      @products = Product.order(name: :asc)
      puts 'Done.'

      erb :'products/index'
    end

    get '/products/:id' do
      puts 'Product#show action running...'
      @product = Product.find(params[:id])
      puts 'Done'
      erb :'products/show'
    end
  end
end
