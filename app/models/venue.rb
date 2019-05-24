class Venue < ApplicationRecord

	has_many :events, dependent: :destroy
	has_many :performers, through: :events

	validates :name, :city, :state, presence: true
	validates :name, uniqueness: { scope: [:city, :state] }

	def location
		if state != "Outside U.S."
			"#{city}, #{state}"
		else
			city
		end
	end

	def extended_name
		"#{name} (#{location})"
	end

end
