require "rails_helper"

RSpec.describe ContactMailer, type: :mailer do
  include_context "fixtures"

  describe "contact_message" do
    let(:mail) { ContactMailer.contact_message("Hello World!") }

    it "renders the headers" do
      expect(mail.subject).to eq("Ticket Track Account Activation")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@tickettrack.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(user.first_name)
      expect(mail.body.encoded).to match(user.activation_token)
      expect(mail.body.encoded).to match(CGI.escape(user.email))
    end
  end