require_relative "../library/connection"

class Transaction < ActiveRecord::Base
	belongs_to :tshirt
end
