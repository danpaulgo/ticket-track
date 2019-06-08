class User < ApplicationRecord

	has_secure_password

	has_many :transactions, dependent: :destroy
	has_many :events, through: :transactions

	validates :name, :email, :birthdate, presence: true
	validates :email, uniqueness: true
	validate :password_min_length_if_present

	attr_accessor :remember_token

	def self.new_token
    SecureRandom.urlsafe_base64
	end	

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, remember_token.digest)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def authenticated?(remember_token)
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def first_name
		name.split(" ").first
	end

	def total_purchase
		sum = 0
		events.uniq.each{|e| sum += e.total_purchase(self)}
		sum
	end

	def total_sale
		sum = 0
		events.uniq.each{|e| sum += e.total_sale(self)}
		sum
	end

	def liquid_profit
		(total_sale - total_purchase).round(2)
	end

	def inventory_value
		sum = 0
		events.uniq.each{|e| sum += e.inventory_value(self)}
		sum
	end

	def total_profit
		(liquid_profit + inventory_value).round(2)
	end

	private

	def password_min_length_if_present
		if !password.nil? && password.length < 6
			errors.add(:date, "Password is too short (minimum is 6 characters)")
		end
	end



end
