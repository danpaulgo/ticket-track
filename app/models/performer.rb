class Performer < ApplicationRecord

	has_many :events, dependent: :destroy
	has_many :venues, through: :events

	validates :name, presence: true
	validates :name, uniqueness: true

	def self.find_or_create(name)
		name = name.titleize
		existing = self.find_by(name: name)
		existing.nil? ? self.create(name: name) : existing
	end

end
