class Venue < ApplicationRecord

	has_many :events
	has_many :performers, through: :events

	validates :name, :city, :state, presence: true
	validates :name, uniqueness: { scope: [:city, :state] }

end
