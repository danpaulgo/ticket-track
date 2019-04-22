require 'rails_helper'

RSpec.describe Event, type: :model do
  
	include_context "fixtures"

	it 'has all necessary fields' do
    expect(Event.new).to respond_to(:performer_id)
    expect(Event.new).to respond_to(:venue_id)
    expect(Event.new).to respond_to(:date)
  end

  it "is valid with an performer_id, venue_id, and date" do
    expect(event).to be_valid
  end

  it "is invalid without a performer_id" do
  	event.performer_id = nil
  	expect(event).not_to be_valid
  end

  it "is invalid without a venue_id" do
  	event.venue_id = nil
  	expect(event).not_to be_valid
  end

  it "is invalid without a date" do
  	event.date = nil
  	expect(event).not_to be_valid
  end

  it "belongs to an artist" do
  	expect(event.performer).to eq(performer)
  end

  it "belongs to a venue" do
  	expect(event.venue).to eq(venue)
	end

	it "has many transactions" do
		expect(event.transactions).to include(purchase)
		expect(event.transactions).to include(sale)
	end

	it "deletes all associated transactions upon being deleted" do
		sale
    purchase
    event.destroy
		expect(Transaction.all).not_to include(purchase, sale)
	end

end
