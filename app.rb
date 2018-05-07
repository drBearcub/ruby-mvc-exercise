require 'sinatra'
require 'HTTParty'
require 'json'

get '/' do
  # HOME LANDING PAGE SHOWING BANNER PHOTO, TITLE, AND SUBTITLE
  @page_title = "Home"
  erb :index
end


get '/team' do
  # Team Page
  @page_title = "Team"
  erb :team
end

get '/products' do
   # Team Page
  load "models/product.rb"
  @products = Product.sample_locations
  @page_title = "All Products"
  erb :products
end


get '/products/location/:location' do
  # PAGE DISPLAYING ALL PHOTOS FROM ONE LOCATION
  load "models/product.rb"
  @products = Product.find_by_location(params[:location])
  @page_title = params[:location]
  erb :location
end

get '/products/:id' do
  # PAGE DISPLAYING ONE PRODUCT WITH A GIVEN ID
  load "models/product.rb"
  @product = Product.find_by_id(params[:id])
  @page_title = @product.title
  erb :id
end
