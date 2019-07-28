class Event < ApplicationRecord

	belongs_to :venue
	belongs_to :performer
	has_many :transactions, dependent: :destroy

	validates :date, presence: true

	def name
		"#{performer.name} @ #{venue.name} (#{formatted_date})"
	end

	def location
		venue.location
	end

	def sales(user)
		user.transactions.where(["event_id = ? and direction = ?", self.id, "Sale"])
	end

	def purchases(user)
		user.transactions.where(["event_id = ? and direction = ?", self.id, "Purchase"])
	end

	def total_purchase(user)
		sum = 0
		purchases(user).each{ |t| sum += t.amount}
		sum
	end

	def total_sale(user)
		sum = 0
		sales(user).each{ |t| sum += t.amount}
		sum
	end

	def average_purchase_price(user)
		tickets_purchased(user) == 0 ? 0 : (total_purchase(user)/tickets_purchased(user)).round(2)
	end

	def average_sale_price(user)
		tickets_sold(user) == 0 ? 0 : (total_sale(user)/tickets_sold(user)).round(2)
	end

	def tickets_purchased(user)
		sum = 0
		purchases(user).each{|t| sum += t.quantity}
		sum
	end

	def tickets_sold(user)
		sum = 0
		sales(user).each{|t| sum += t.quantity}
		sum
	end

	def tickets_remaining(user)
		tickets_purchased(user) - self.tickets_sold(user)
	end

	def inventory_value(user)
		(average_purchase_price(user) * tickets_remaining(user)).round(2)
	end

	def liquid_profit(user)
		(total_sale(user) - total_purchase(user)).round(2)
	end

	def total_profit(user)
		(liquid_profit(user) + inventory_value(user)).round(2)
	end

end
