require 'rails_helper'

RSpec.describe Venue, type: :model do

  include_context "fixtures"

	it 'has all necessary fields' do
    expect(Venue.new).to respond_to(:name)
    expect(Venue.new).to respond_to(:city)
    expect(Venue.new).to respond_to(:state)
  end

  it "is valid with a name, city and state" do
    expect(venue).to be_valid
  end

  it "is invalid without a name" do
  	venue.name = nil
  	expect(venue).not_to be_valid
  	venue.name = ""
  	expect(venue).not_to be_valid
  end

  it "is invalid without a city" do 
  	venue.city = nil
  	expect(venue).not_to be_valid
  	venue.name = ""
  	expect(venue).not_to be_valid
  end

  it "is invalid without a state" do 
  	venue.state = nil
  	expect(venue).not_to be_valid
  	venue.state = ""
  	expect(venue).not_to be_valid
  end

  it "is invalid with the same name exact attributes as another venue" do
  	venue_two = Venue.new(
  		name: venue.name,
  		city: venue.city,
  		state: venue.state
  	)
  	expect(venue_two).not_to be_valid
  end

  it "has many events and many performers through events" do
  	expect(venue.events).to include(event)
  	expect(venue.performers).to include(performer)
  end

  it "deletes all associated events and transactions upon being deleted" do
  	event
    purchase
    sale
    venue.destroy
    expect(Event.all).not_to include(event)
    expect(Transaction.all).not_to include(purchase, sale)
  end

  it "titleizes name before saving" do
    venue.name = "madison square garden"
    venue.save
    expect(venue.name).to eq("Madison Square Garden")
  end

end
