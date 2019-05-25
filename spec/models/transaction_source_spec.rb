require 'rails_helper'

RSpec.describe TransactionSource, type: :model do
  include_context "fixtures"

	it 'has all necessary fields' do
    expect(TransactionSource.new).to respond_to(:name)
  end

  it "is valid with a name" do
    expect(ticketmaster).to be_valid
  end

  it "is invalid without a name" do
  	ticketmaster.name = nil
  	expect(ticketmaster).not_to be_valid
  	stubhub.name = ""
  	expect(stubhub).not_to be_valid
  end

  it "is invalid with a name that has been taken" do
  	ticketmaster
  	expect(TransactionSource.new(name:"Ticketmaster")).not_to be_valid
  end

  it "deletes all associated events transactions upon being deleted" do
    purchase
    ticketmaster.destroy
    expect(Transaction.all).not_to include(purchase)
  end

	it "titleizes source name before saving" do
		vivid = TransactionSource.new(name: "vivid seats")
		vivid.save
		expect(TransactionSource.last.name).to eq("Vivid Seats")
	end

  describe "find_or_create" do
    it "returns transaction source if source with name exists" do
      ticketmaster
      stubhub
      expect{TransactionSource.find_or_create("stubhub")}.not_to change(TransactionSource, :count)
      expect(TransactionSource.find_or_create("stubhub")).to eq(stubhub)
    end

    it "creates performer if no performer exists with name" do
      ticketmaster
      stubhub
      expect{TransactionSource.find_or_create("tickpick")}.to change(TransactionSource, :count).by(1)
      expect(TransactionSource.last.name).to eq("Tickpick")
    end
  end

end
