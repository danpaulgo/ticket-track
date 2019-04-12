class TransactionSource < ApplicationRecord

	has_many :transactions

	validates :name, presence: true
	validates :name, uniqueness: true

	before_validation :titleize_name

end
