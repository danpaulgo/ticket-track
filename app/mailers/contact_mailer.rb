class ContactMailer < ApplicationMailer

  def contact_message(contact)
    @contact = contact
    mail to: "danpaulgo@aol.com", subject: contact.subject
  end

end
