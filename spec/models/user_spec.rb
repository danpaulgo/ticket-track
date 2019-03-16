require 'rails_helper'

RSpec.describe User, :type => :model do

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
    user.name = ""
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
    user_two = User.new(
      name: "Johnny Doe",
      email: user.email,
      birthdate: "2000-01-01",
      password: "password"
    )
    expect(user_two).not_to be_valid
  end

  it "has many transactions and many events through transactions" do
    expect(user.transactions).to include(purchase)
    expect(user.transactions).to include(sale)
    expect(user.events).to include(event)
  end

  it "deletes all associated transactions upon being deleted" do
    user.delete
    expect(Transaction.find_by(id: sale.id)).to be_nil
    expect(Transaction.find_by(id: purchase.id)).to be_nil
  end

end
