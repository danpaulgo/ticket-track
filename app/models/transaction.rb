class Transaction < ApplicationRecord

	belongs_to :user
	belongs_to :event
	belongs_to :transaction_source

	validates :order_number, :transaction_source_id, :date, presence: true
	validates :direction, inclusion: { in: %w(Purchase Sale)}
	validates :quantity, numericality: { greater_than_or_equal_to: 1}
	validates :amount, numericality: { greater_than: 0}
	validates :order_number, uniqueness: { scope: :transaction_source_id }
	validate :date_cannot_be_after_event_date, :date_cannot_be_in_future

	before_validation :capitalize_direction 

	def price
		"$#{'%.2f' % amount}"
	end

	private

	def capitalize_direction
		self.direction.capitalize! if direction
	end

	def date_cannot_be_in_future
    if date && date > Date.today
      errors.add(:date, "Cannot be in the future")
    end
  end

  def date_cannot_be_after_event_date
    if date && event && date > event.date
      errors.add(:date, "Cannot be after event")
    end
  end

end
