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
  DATA = HTTParty.get('https://fomotograph-api.udacity.com/products.json')['photos'] 
  @product = DATA.select { |prod| prod['id'] == params[:id].to_i }.first 
  erb "<!DOCTYPE html>
  <html>
  <head>
    <title>Fomotograph | <%= @product['title'] %> </title>
    <link rel='stylesheet' type='text/css' href='<%= url('/style.css') %>'>
    <link href='https://fonts.googleapis.com/css?family=Work+Sans:400,500,600' rel='stylesheet' type='text/css'>
  </head>

  <body>

    <div id='container'>

      <div id='header'>
        <a href='/'><img src='/logo-black-text.png' alt='logo image' class='logo'/></a>
        <a href='/team' class='nav'>Team</a>
        <a href='/products' class='nav'>Products</a>
      </div>

      <div id='main'>
        <h1><%= @product['title'] %></h1>
        <a class='small-button' href='#'>Fomotograph Me!</a>
        <p class='summary'> <%= @product['summary'] %> </p>
        <p class='summary'>Order your prints today for $<%= @product['price'] %></p>
        <img class='full' src='<%= @product['url'] %>' />
        <a class='small-button' href='/products/location/<%= @product['location'] %>'> View All <%= @product['location'] != 'us' ? @product['location'].capitalize : @product['location'].upcase %> Products </a>
      </div>

      <div id='footer'>
        © Fomotograph
      </div>

    </div>

  </body>
  </html>"
end
