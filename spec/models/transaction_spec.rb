require 'rails_helper'

RSpec.describe Transaction, type: :model do
  
	include_context "fixtures"

	it "has all necessary fields" do
		expect(Transaction.new).to respond_to(:event_id)
		expect(Transaction.new).to respond_to(:user_id)
		expect(Transaction.new).to respond_to(:amount)
		expect(Transaction.new).to respond_to(:direction)
		expect(Transaction.new).to respond_to(:quantity)
	end

	it "is valid with an event_id, user_id, amount, direction, and quantity" do
		expect(purchase).to be_valid
	end

	it "is invalid without an event_id" do
		purchase.event_id = nil
		expect(purchase).not_to be_valid
	end

	it "is invalid without a user_id" do
		purchase.user_id = nil
		expect(purchase).not_to be_valid
	end

	it "is invalid without an amount" do
		purchase.amount = nil
		expect(purchase).not_to be_valid
	end	

	it "is invalid without a direction" do
		purchase.direction = nil
		expect(purchase).not_to be_valid
	end

	it "is invalid without a quantity" do
		purchase.quantity = nil
		expect(purchase).not_to be_valid
	end

	it "is invalid with a negative amount" do
		purchase.amount = -99.99
		expect(purchase).not_to be_valid
	end

	it "is invalid with a type not equal to 'sale' or 'purchase'" do
		purchase.direction = "foo"
	end

	it "is invalid with a quantity of less than 1" do
		purchase.quantity = 0
		expect(purchase).not_to be_valid
		sale.quantity = -1
		expect(sale).not_to be_valid
	end

end
