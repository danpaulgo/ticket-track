require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  include_context "fixtures"

  describe "account_activation" do
    let(:mail) { UserMailer.account_activation(user) }

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

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(user) }
    before(:each){ user.create_reset_digest }
    it "renders the headers" do
      expect(mail.subject).to eq("Ticket Track Password Reset Link")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@tickettrack.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(user.reset_token)
      expect(mail.body.encoded).to match(CGI.escape(user.email))
    end
  end

end
