class User < ApplicationRecord

	has_secure_password

	has_many :transactions
	has_many :events, through: :transactions

end
