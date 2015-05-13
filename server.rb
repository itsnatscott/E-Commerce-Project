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
	# Tshirt is an Active Record model created as a subclass of the the ActiveRecord::Base class 
	# Tshirt.all is equivalent to SELECT * FROM tshirts
	tshirts = Tshirt.all
	# pass all tshirts to the index form
	erb :index, locals: {tshirts: tshirts}
end

#Order screen where user puts their data after clicking 'buy' on 'index page'
get '/index/:id' do
    tshirtId = Tshirt.find(params[:id]) 
    # pass specific tshirt info. to the purchase form 
    erb :purchase, locals: {tshirtId: tshirtId}
end

# admin page for creation, deletion and editing of inventory
get '/admin' do
	# all tshirts and purchases passed to the admin view
	tshirts = Tshirt.all
	purchases = Transaction.all
	erb :admin, locals: {tshirts: tshirts, purchases: purchases}
end

#Show a shirt and its transactions from 'Admin page'
get '/admin/:id' do 
	shirt = Tshirt.find(params[:id])
	shirtTransactions = shirt.transactions
	# shirt and transactions passed to show view
	erb :show, locals: {shirt: shirt, shirtTransactions: shirtTransactions}
end

#Confirmation of purchase from 'purchase view' after 'post' to database
get '/index/:id/confirm' do
	shirt = Tshirt.find(params[:id])
	# grab the last t-shirt transaction info, i.e. email, tshirt_id, trans_quant (as opposed to the tshirt info)
	shirtTrans = shirt.transactions.last
	# set purch_quant to the transaction quantity
	purch_quant = shirtTrans.trans_quant
	total = purch_quant * shirt.price
	erb :confirm, locals: {shirt: shirt, shirtTransaction: shirtTrans, total: total}
end

#Update a tshirt from 'admin show page'
put '/admin/:id' do
	shirt = Tshirt.find(params[:id])
	# grab the inputs from the edit form
	new_pic = params[:shirt_url]
	new_price = params[:price]
	new_quant = params[:quant]
	# update the database with the new inputs
	shirt.update({quantity: new_quant, price: new_price, img_url: new_pic})
	redirect ('/admin')
end

#create a new transaction from the 'purchase view' before 'get' to confirmation
post '/index/:id' do
	shirt = Tshirt.find(params[:id])
	shirt_quant = shirt.quantity
	trans_quant= params[:quant].to_i
	# subtract purchased quantity from shirt quantity; update database
	new_quant = shirt_quant - trans_quant
	shirt.update({quantity: new_quant})
	# add the new transaction to the database
	Transaction.create({email: params[:email], tshirt_id: params[:id], trans_quant: trans_quant})
	redirect ("/index/#{params[:id]}/confirm")
end

#Add a new shirt to the site from 'admin page'
post '/admin' do
	# grab the inputs from the add form
	new_pic = params[:shirt_url]
	new_price = params[:price]
	new_quant = params[:quant]
	# add the new tshirt to the database
	# binding.pry
	Tshirt.create({quantity: new_quant, price: new_price, img_url: new_pic})
	redirect ('/admin')
end

#Delete a shirt
delete '/admin/:id' do
	shirt = Tshirt.find(params[:id])
	shirt.destroy
	redirect ('/admin')
end




