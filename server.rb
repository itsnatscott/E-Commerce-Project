require 'sinatra'
require 'pry'
require 'sqlite3'

require_relative 'models/tshirt'
require_relative 'models/transaction'

# Home redirect
get '/' do 
redirect '/index'
end

# Home page
get '/index' do
	# Passing SELECT * FROM Tshirts
	tshirts = Tshirt.all
	erb :index, locals {tshirts: tshirts}
end


