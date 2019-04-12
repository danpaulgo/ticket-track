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
  	expect(Transaction.new(name:"Ticketmaster")).not_to be_valid
  end

  it "deletes all associated events transactions upon being deleted" do
    ticketmaster.destroy
    expect(Event.all).not_to include(purchase)
  end


end
