require 'rails_helper'

RSpec.describe Performer, type: :model do

	it 'has all necessary fields' do
    expect(Performer.new).to respond_to(:name)
  end

  it "is valid with a name" do
    expect(performer).to be_valid
  end

  it "is invalid without a name" do
  	performer.name = nil
  	expect(performer).not_to be_valid
  	performer.name = ""
  	expect(performer).not_to be_valid
  end

  it "has many events" do
  	expect(performer.events).to include(event)
  end

  it "has many venues through events" do
  	expect(performer.venut).to include(venue)
  end

  it "deletes all associated events and transactions upon being deleted" do
  	performer.delete
  	expect(Event.find_by(id: event.id)).to be_nil
  	expect(Transaction.find_by(id: sale.id)).to be_nil
  	expect(Transaction.find_by(id: purchase.id)).to be_nil
  end

end
