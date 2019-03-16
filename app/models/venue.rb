class Venue < ApplicationRecord

	has_many :events, dependent: :destroy
	has_many :performers, through: :events

	validates :name, :city, :state, presence: true
	validates :name, uniqueness: { scope: [:city, :state] }

end
