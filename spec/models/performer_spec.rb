require 'rails_helper'

RSpec.describe Performer, type: :model do

	include_context "fixtures"

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

  it "is invalid with a name that has been taken" do
    performer
    expect(Performer.new(name:"Drake")).not_to be_valid
  end

  it "has many events and many venues through events" do
  	expect(performer.events).to include(event)
  	expect(performer.venues).to include(venue)
  end

  it "deletes all associated events and transactions upon being deleted" do
    event
    purchase
    sale
    performer.destroy
    expect(Event.all).not_to include(event)
    expect(Transaction.all).not_to include(purchase, sale)
  end

  it "titleizes name before saving" do
    performer.name = "alison wonderland"
    performer.save
    expect(performer.name).to eq("Alison Wonderland")
  end

  describe "find_or_create" do
    it "returns performer if performer with name exists" do
      performer
      performer_2
      expect{Performer.find_or_create("drake")}.not_to change(Performer, :count)
      expect(Performer.find_or_create("drake")).to eq(performer)
    end

    it "creates performer if no performer exists with name" do
      performer
      performer_2
      expect{Performer.find_or_create("rihanna")}.to change(Performer, :count).by(1)
      expect(Performer.last.name).to eq("Rihanna")
    end
  end

end
