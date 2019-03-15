require 'rails_helper'

RSpec.describe Transaction, type: :model do
  
	include_context "fixtures"
	let(:valid_user){user.save}
	# let(:valid_event){event.save}

	it "has all necessary fields" do
		expect(Transaction.new).to respond_to(:event_id)
		expect(Transaction.new).to respond_to(:user_id)
		expect(Transaction.new).to respond_to(:amount)
		expect(Transaction.new).to respond_to(:type)
		expect(Transaction.new).to respond_to(:quantity)
	end

	it "is valid with an event_id, user_id, amount, type, and quantity" do

	end

	it "is invalid without an event_id" do

	end

	it "is invalid without a user_id" do

	end

	it "is invalid without an amount" do

	end	

	it "is invalid without a type" do

	end

	it "is invalid without a quantity" do

	end

	it "is invalid with a negative amount" do

	end

	it "is invalid with a type not equal to 'sale' or 'purchase'" do

	end

	it "is invalid with a quantity of less than 1" do

	end

end
