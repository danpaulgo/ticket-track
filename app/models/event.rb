class Event < ApplicationRecord

	belongs_to :venue
	belongs_to :performer
	has_many :transactions

	validates :date, presence: true

end
