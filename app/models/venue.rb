class Venue < ApplicationRecord

	has_many :events
	has_many :performers, through: :events

end
