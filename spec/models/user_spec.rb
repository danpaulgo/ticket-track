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
    sale
    purchase
    user.destroy
    expect(Transaction.all).not_to include(purchase, sale)
  end

  describe "first_name" do
    it "returns user's first name" do
      expect(admin.first_name).to eq("Daniel")
    end
  end

  context "caluclation actions" do
    before(:each) do 
      admin_purchase
      admin_purchase_2
      admin_sale
      admin_sale_2
      admin_sale_3
    end

    describe "total_purchase" do
      it "returns sum of all user's purchases" do
        expect(admin.total_purchase).to eq(321.55)
      end
    end

    describe "total_sale" do
      it "returns sum of all user's sales" do
        expect(admin.total_sale).to eq(302.81)
      end
    end

    describe "liquid_profit" do
      it "returns user's total purchases minus total sales" do
        expect(admin.liquid_profit).to eq(-18.74)
      end
    end

    describe "inventory_value" do
      it "returns the value of all tickets user currently holds based on purchase price" do
        expect(admin.inventory_value).to eq(81.04)
      end
    end

    describe "total_profit" do
      it "returns liquid profits plus inventory value" do
        expect(admin.total_profit).to eq(62.30)
      end
    end

  end

end
