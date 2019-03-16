class Transaction < ApplicationRecord

	belongs_to :user
	belongs_to :event

	validates :order_number, :source, presence: true
	validates :direction, inclusion: { in: %w(Purchase Sale)}
	validates :quantity, numericality: { greater_than_or_equal_to: 1}
	validates :amount, numericality: { greater_than: 0}
	validates :order_number, uniqueness: { scope: :source }

	before_validation :capitalize_direction 
	before_save :titleize_source

	private

	def capitalize_direction
		self.direction.capitalize! if direction
	end

	def titleize_source
		self.source = source.titleize if source
	end

end
