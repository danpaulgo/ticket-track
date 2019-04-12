class Performer < ApplicationRecord

	has_many :events, dependent: :destroy
	has_many :venues, through: :events

	validates :name, presence: true
	validates :name, uniqueness: true

	before_validation :titleize_name

end
