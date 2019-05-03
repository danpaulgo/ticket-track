class Event < ApplicationRecord

	belongs_to :venue
	belongs_to :performer
	has_many :transactions, dependent: :destroy

	validates :date, presence: true

	def name
		string_date = date.strftime("%m/%e/%Y")
		"#{performer.name} @ #{venue.name} (#{string_date})"
	end

end
