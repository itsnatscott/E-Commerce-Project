require 'sinatra'
require 'pry'
require 'sqlite3'

require_relative 'models/tshirt'
require_relative 'models/transaction'
require_relative 'library/connection'

# Home redirect
get '/' do 
redirect '/index'
end

# Home page
get '/index' do
	# Passing SELECT * FROM Tshirts
	tshirts = Tshirt.all
	erb :index, locals: {tshirts: tshirts}
end

# order screen where user puts their data after clicking purchase button for tshirt
get '/index/:id' do
	params = params[:id]
	tshirtId = Tshirt.find_by(params) 
	erb :purchase, locals: {tshirtId: tshirtId}
end

# admin page for creation, deletion and editing of inventory
get '/admin' do
	# shirt = Tshirt.find(params[:id])
	# shirtTransactions = shirt.transactions
	purchases = Transaction.all
	tshirts = Tshirt.all
	# binding.pry
	erb :admin, locals: {tshirts: tshirts, purchases: purchases}
end

get '/admin/:id' do 
	shirt = Tshirt.find(params[:id])
	shirtTransactions = shirt.transactions
	erb :show, locals: {shirt: shirt, shirtTransactions: shirtTransactionss}
end





