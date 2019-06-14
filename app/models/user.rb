class User < ApplicationRecord

	has_secure_password

	has_many :transactions, dependent: :destroy
	has_many :events, through: :transactions

	validates :name, :email, :birthdate, presence: true
	validates :email, uniqueness: true
	validate :password_min_length_if_present

	before_create :create_activation_digest, :downcase_email

	attr_accessor :remember_token, :activation_token, :reset_token

	def self.new_token
    SecureRandom.urlsafe_base64
	end	

	def self.exists(id)
		self.find_by(id: id)
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, remember_token.digest)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def authenticated?(attribute, token)
		digest = self.send("#{attribute}_digest")
		if digest.nil?
			false
		else
			BCrypt::Password.new(digest).is_password?(token)
		end
	end

	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	def activate
		self.update_attributes(activated: true, activated_at: Time.now)
	end

	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest, reset_token.digest)
		update_attribute(:reset_sent_at, Time.zone.now)
 
	end

	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
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

	def create_activation_digest
		self.activation_token = User.new_token
		self.activation_digest = activation_token.digest
	end

	def downcase_email
		email.downcase!
	end

end
