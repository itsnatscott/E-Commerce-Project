require_relative '../models/tshirt'
require_relative '../models/transaction'

Tshirt.create({
quantity: 10,
price: 12.99,
img_url: "http://i.imgur.com/Eb93kBc.png"
})


Tshirt.create({
quantity: 20,
price: 10.99,
img_url: "http://i.imgur.com/Eb93kBc.png"
})


Tshirt.create({
quantity: 5,
price: 20.99,
img_url: "http://i.imgur.com/Eb93kBc.png"
})

Tshirt.create({
quantity: 30,
price: 7.99,
img_url: "http://i.imgur.com/Eb93kBc.png"
})

Tshirt.create({
quantity: 12,
price: 13.50,
img_url: "http://i.imgur.com/Eb93kBc.png"
})

Transaction.create({
email: "aung@email.com",
tshirt_id: 1,
trans_quant:5
})

Transaction.create({
email: "andy@email.com",
tshirt_id: 2,
trans_quant:4
})

Transaction.create({
email: "meir@email.com",
tshirt_id: 3,
trans_quant:6
})

Transaction.create({
email: "itsnat@email.com",
tshirt_id: 3,
trans_quant:2
})