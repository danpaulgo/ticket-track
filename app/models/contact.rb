class Contact

	include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

	ATTRIBUTES = [:email, :subject, :message]

	ATTRIBUTES.each do |attr|
		attr_accessor attr
	end

	# attr_accessor ATTRIBUTES

	validates :email, :subject, :message, presence: true, allow_blank: false

	def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def send_message
  	ContactMailer.contact_message(self).deliver_now
  end

end
