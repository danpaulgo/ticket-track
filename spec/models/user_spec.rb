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

  it "is invalid without a name" do

  end

  it "is invalid without a password_digest" do 

  end

  it "is invalid without an email" do

  end

  it "is invalid with an e-mail that has already been taken" do

  end

  it "is invalid with a password fewer than 6 characters" do

  end

end
