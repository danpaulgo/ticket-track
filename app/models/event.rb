class Event < ApplicationRecord

	belongs_to :venue
	belongs_to :performer
	has_many :transactions, dependent: :destroy

	validates :date, presence: true

end
