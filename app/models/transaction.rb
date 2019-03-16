class Transaction < ApplicationRecord

	belongs_to :user
	belongs_to :event

	validates :order_number, presence: true
	validates :direction, inclusion: { in: %w(Purchase Sale)}
	validates :quantity, numericality: { greater_than_or_equal_to: 1}
	validates :amount, numericality: { greater_than: 0}

	before_validation :capitalize_direction

	private

	def capitalize_direction
		direction.capitalize!
	end

end
