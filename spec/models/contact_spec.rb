require 'rails_helper'

RSpec.describe Contact, type: :model do

  include_context "fixtures"

	it 'has all necessary fields' do
    expect(Contact.new).to respond_to(:email)
    expect(Contact.new).to respond_to(:subject)
    expect(Contact.new).to respond_to(:message)
  end

  it "is valid with an email, subject" do
    expect(contact_message).to be_valid
  end

  it "is invalid without an email" do
    contact_message.email = nil
    expect(contact_message).not_to be_valid
    contact_message.email = ""
    expect(contact_message).not_to be_valid
  end

  it "is invalid without a subject" do
    contact_message.subject = nil
    expect(contact_message).not_to be_valid
    contact_message.subject = ""
    expect(contact_message).not_to be_valid
  end

  it "is invalid without a message" do
    contact_message.message = nil
    expect(contact_message).not_to be_valid
    contact_message.message = ""
    expect(contact_message).not_to be_valid
  end

end
