class Performer < ApplicationRecord

	has_many :events
	has_many :venues, through: :events

	validates :name, presence: true

end
