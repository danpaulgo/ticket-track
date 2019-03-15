require 'rails_helper'

RSpec.describe User, :type => :model do
  
  # let(:user) {
  #   User.new(
  #     name: "John Doe",
  #     email: "johndoe2000@gmail.com",
  #     password: "password",
  #     password_confirmation: "password",
  #     birthdate: "2000-12-31"
  #   )
  # }

  include_context "fixtures"

  it 'has all necessary fields' do
    expect(User.new).to respond_to(:name)
    expect(User.new).to respond_to(:email)
    expect(User.new).to respond_to(:birthdate)
    expect(User.new).to respond_to(:password)
    expect(User.new).to respond_to(:password_confirmation)
  end

  it "is valid with a name, email, password, and matching password_confirmation" do
    expect(user).to be_valid
  end

  it "is valid if password is set and password_confirmation is nil" do
     user.password_confirmation = nil
     expect(user.valid?).to be true 
  end

  it "is invalid if password and password_confirmation are both non-nil and don't match" do
    user.password_confirmation = 'passw0rd'
    expect(user.valid?).to be false
  end

  it "is invalid without a name" do
    user.name = nil
    expect(user).not_to be_valid
  end

  it "is invalid with a password fewer than 6 characters" do 
    user.password = "short"
    user.password_confirmation = nil
    expect(user).not_to be_valid
    user.password_confirmation = "short"
    expect(user).not_to be_valid
  end

  it "is invalid without an email" do
    user.email = nil
    expect(user).not_to be_valid
  end

  it "is invalid with an e-mail that has already been taken" do
    user_two = user
    user.save
    expect(user_two).not_to be_valid
  end

  it "has many transactions" do

  end

  it "has many events through transactions" do

  end

end
