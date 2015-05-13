require_relative "../library/connection"

class Tshirt < ActiveRecord::Base
	has_many :transactions
end
