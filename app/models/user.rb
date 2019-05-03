class User < ApplicationRecord

	has_secure_password

	has_many :transactions, dependent: :destroy
	has_many :events, through: :transactions

	validates :name, :email, :birthdate, presence: true
	validates :email, uniqueness: true
	validates :password, length: { minimum: 6 }

	def first_name
		name.split(" ").first
	end

end
