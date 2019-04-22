class TransactionSource < ApplicationRecord

	has_many :transactions, dependent: :destroy

	validates :name, presence: true
	validates :name, uniqueness: true

	before_validation :titleize_name

end
