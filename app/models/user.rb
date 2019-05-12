class User < ApplicationRecord

	has_secure_password

	has_many :transactions, dependent: :destroy
	has_many :events, through: :transactions

	validates :name, :email, :birthdate, presence: true
	validates :email, uniqueness: true
	validates :password, length: { minimum: 6 }

	def first_name
		name.split(" ").first
	end

	def total_purchase
		sum = 0
		events.uniq.each{|e| sum += e.total_purchase(self)}
		sum
	end

	def total_sale
		sum = 0
		events.uniq.each{|e| sum += e.total_sale(self)}
		sum
	end

	def liquid_profit
		(total_sale - total_purchase).round(2)
	end

	def inventory_value
		sum = 0
		events.uniq.each{|e| sum += e.inventory_value(self)}
		sum
	end

	def total_profit
		(liquid_profit + inventory_value).round(2)
	end

end
