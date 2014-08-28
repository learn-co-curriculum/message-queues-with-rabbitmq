module ProductCmsApp
  class ProductsController < ApplicationController
    get '/products' do
      @products = Product.all
      erb :'products/index'
    end

    get '/products/new' do
      erb :'products/new'
    end

    post '/products' do
      Product.create(params[:product])
      redirect to("/products")
    end

    get '/products/:id/edit' do
      @product = Product.find(params[:id])
      erb :'products/edit'
    end

    post '/products/:id/update' do
      product = Product.find(params[:id])
      product.update(params[:product])
      redirect to("/products")
    end

    post '/products/:id/destroy' do
      product = Product.find(params[:id])
      product.destroy
      redirect to("/products")
    end
  end
end
