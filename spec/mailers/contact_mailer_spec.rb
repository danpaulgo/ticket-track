require "rails_helper"

RSpec.describe ContactMailer, type: :mailer do
  include_context "fixtures"

  describe "contact_message" do
    let(:mail) { ContactMailer.contact_message(contact_message) }

    it "renders the headers" do
      expect(mail.subject).to eq("Testing")
      expect(mail.to).to eq(["danpaulgo@gmail.com"])
      expect(mail.from).to eq(["noreply@tickettrack.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hello World!")
    end
  end
end