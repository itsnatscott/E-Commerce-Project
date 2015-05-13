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
#show a shirt and all of its transactions ... 'Admin show page'
get '/admin/:id' do 
	shirt = Tshirt.find(params[:id])
	shirtTransactions = shirt.transactions
	erb :show, locals: {shirt: shirt, shirtTransactions: shirtTransactions}
end

#Confirmation of purchase
get '/index/:id/confirm' do
	id=params[:id]
	shirt = Tshirt.find(params[:id])
	shirtTrans = shirt.transactions.last
	erb :confirm , locals: {shirt: shirt, shirtTransaction: shirtTrans}
end

#update a tshirt from 'admin show page'
put '/admin/:id' do
	shirt = Tshirt.find(params[:id])
	new_pic = params[:shirt_url]
	new_price = params[:price]
	new_quant = params[:quant]
	shirt.update({quantity: new_quant, price: new_price, img_url: new_pic})
	redirect ('/admin')
end
#subtract purchased quantity from shirt id, add transaction row to table
post 'index/:id' do
	shirt = Tshirt.find(params[:id])
	shirt_quant = shirt.quantity
	trans_quant= params[:quant].to_i
	new_quant = shirt_quant - trans_quant
	trans_email= params[:email]
	shirt_id= params[:id]
	shirt.update({quantity: new_quant})
	Transaction.create({email: trans_email, tshirt_id: shirt_id})
	redirect ('index/#{params[:id]}/confirm')
end
#add a new shirt to the site
post '/admin' do
	new_pic = params[:shirt_url]
	new_price = params[:price]
	new_quant = params[:quant]
	Tshirt.create({quantity: new_quant, price: new_price, img_url: new_pic})
	redirect ('/admin')
end
#delete a shirt
delete '/admin/:id' do
	shirt = Tshirt.find(params[:id])
	shirt.destroy
	redirect ('/admin')
end




