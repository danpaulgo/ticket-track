require 'rails_helper'

RSpec.describe Transaction, type: :model do
  
	include_context "fixtures"

	it "has all necessary fields" do
		expect(Transaction.new).to respond_to(:event_id)
		expect(Transaction.new).to respond_to(:user_id)
		expect(Transaction.new).to respond_to(:amount)
		expect(Transaction.new).to respond_to(:direction)
		expect(Transaction.new).to respond_to(:quantity)
		expect(Transaction.new).to respond_to(:order_number)
		expect(Transaction.new).to respond_to(:transaction_source_id)
		expect(Transaction.new).to respond_to(:date)
	end

	it "is valid with all attributes present" do
		expect(purchase).to be_valid
		expect(sale).to be_valid
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

	it "is invalid without an order number" do
		purchase.order_number = nil
		expect(purchase).not_to be_valid
		purchase.order_number = ""
		expect(purchase).not_to be_valid
	end

	it "is invalid without a source" do
		purchase.transaction_source_id = nil
		expect(purchase).not_to be_valid
	end

	it "is invalid without a date" do
		purchase.date = nil
		expect(purchase).not_to be_valid
	end

	it "is invalid with the same order number and source as another transaction" do
		purchase_two = Transaction.new(
			event_id: event.id,
      user_id: user.id,
      direction: "purchase",
      amount: 49.99,
      quantity: 1,
      order_number: purchase.order_number,
      transaction_source_id: purchase.transaction_source.id,
      date: purchase.date
		)
		expect(purchase_two).not_to be_valid
	end

	it "is valid with same order number as another transaction if sources are different" do
		purchase
		expect(sale).to be_valid
	end

	it "is invalid with a negative amount" do
		purchase.amount = -99.99
		expect(purchase).not_to be_valid
	end

	it "is invalid with a direction not equal to 'Sale' or 'Purchase'" do
		purchase.direction = "foo"
		expect(purchase).not_to be_valid
	end

	it "is invalid with a quantity of less than 1" do
		purchase.quantity = 0
		expect(purchase).not_to be_valid
		sale.quantity = -1
		expect(sale).not_to be_valid
	end

	it "belongs to an event" do
		expect(purchase.event).to eq(event)
		expect(sale.event).to eq(event)
	end

	it "belongs to a user" do
		expect(purchase.user).to eq(user)
		expect(sale.user).to eq(user)
	end

	it "is invalid with date after event date" do
		purchase.date = purchase.event.date + 1.day
		expect(purchase).not_to be_valid
	end

	it "is invalid with date in future" do
		purchase.date = Date.today + 1.day
		expect(purchase).not_to be_valid
	end

	describe "price" do
		it "returns amount with dollar sign and 2 decimal places" do
			expect(admin_purchase.price).to eq("$200.00")
		end
	end

end
