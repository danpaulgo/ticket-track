class ContactMailer < ApplicationMailer

  def contact_message(contact)
    @contact = contact
    mail to: "danpaulgo@aol.com", from: contact.email, subject: contact.subject
  end

end
