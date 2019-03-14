require 'rails_helper'

RSpec.describe User, :type => :model do
  
  let(:user) {
    User.create(
      name: "John Doe",
      email: "johndoe2000@gmail.com",
      password_digest: "password",
      birthdate: "2000-12-31"
    )
  }

  it "is valid with a name, email, and password_digest" do
    expect(user).to be_valid
  end

end
