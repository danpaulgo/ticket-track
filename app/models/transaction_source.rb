class TransactionSource < ApplicationRecord

	has_many :transactions, dependent: :destroy

	validates :name, presence: true
	validates :name, uniqueness: true

	before_validation :titleize_name

	def self.find_or_create(name)
		name = name.titleize
		existing = self.find_by(name: name)
		existing.nil? ? self.create(name: name) : existing
	end

end
