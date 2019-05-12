class Transaction < ApplicationRecord

	belongs_to :user
	belongs_to :event
	belongs_to :transaction_source

	validates :order_number, :transaction_source_id, :date, presence: true
	validates :direction, inclusion: { in: %w(Purchase Sale)}
	validates :quantity, numericality: { greater_than_or_equal_to: 1}
	validates :amount, numericality: { greater_than: 0}
	validates :order_number, uniqueness: { scope: :transaction_source_id }

	before_validation :capitalize_direction 

	def price
		"$#{'%.2f' % amount}"
	end

	private

	def capitalize_direction
		self.direction.capitalize! if direction
	end

end
