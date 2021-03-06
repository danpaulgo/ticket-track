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

  describe "name" do
    it "returns formatted name based on attributes" do
      expect(event_2.name).to eq("Eminem @ House Of Blues (12/31/2020)")
    end 
  end

  describe "location" do
    it "returns string with the city and state of the event's venue" do
      expect(event.location).to eq("New York, NY")
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
      it "returns sum of all purchases for event from specified user" do
        expect(event.total_purchase(admin)).to eq(121.55)
      end
    end

    describe "total_sale" do
      it "returns sum of all sales for event from specified user" do
        expect(event_2.total_sale(admin)).to eq(250.0)
      end
    end

    describe "average_purchase_price" do
      it "returns the average price of all tickets purchased by user" do
        expect(event_2.average_purchase_price(admin)).to eq(50)
      end
    end

    describe "average_sale_price" do
      it "returns the average price of all tickets sold by user" do
        expect(event_2.average_sale_price(admin)).to eq(62.5)
      end
    end

    describe "tickets_purchased" do
      it "returns the quantity of tickets purchased by user" do
        expect(event.tickets_purchased(admin)).to eq(3)
        expect(event_2.tickets_purchased(admin)).to eq(4)
      end
    end

    describe "tickets_sold" do
      it "returns the quantity of tickets sold by user" do
        expect(event.tickets_sold(admin)).to eq(1)
        expect(event_2.tickets_sold(admin)).to eq(4)
      end
    end

    describe "tickets_remaining" do
      it "returns the quantity of tickets still held by user" do
        expect(event.tickets_remaining(admin)).to eq(2)
        expect(event_2.tickets_remaining(admin)).to eq(0)
      end
    end

    describe "actual_inventory_value" do
      it "returns the total value of a user's remaining tickets based on average purchase price" do
        expect(event.actual_inventory_value(admin)).to eq(81.04)
        expect(event_2.actual_inventory_value(admin)).to eq(0)
      end
    end

    describe "projected_inventory_value" do
      it "returns the total value of a user's remaining tickets based on average sale price" do
        expect(event.projected_inventory_value(admin)).to eq(105.62)
        expect(event_2.projected_inventory_value(admin)).to eq(0)
      end
    end

    describe "liquid_profit" do
      it "returns value of a user's total sales minus total purchases" do
        expect(event.liquid_profit(admin)).to eq(-68.74)
        expect(event_2.liquid_profit(admin)).to eq(50)
      end
    end

    # describe "total_profit" do
    #   it "returns liquid profits plus inventory value" do
    #     expect(event.total_profit(admin)).to eq(12.30)
    #     expect(event_2.total_profit(admin)).to eq(50)
    #   end
    # end

    describe "projected_profit" do
      it "returns projected profit based on liquid profit and projected inventory value" do
        expect(event.projected_profit(admin)).to eq(36.88)
      end
    end

    describe "complete?" do
      it "returns true if all purchased tickets are sold" do
        expect(event.complete?(admin)).to eq(false)
        expect(event_2.complete?(admin)).to eq(true)
      end
    end

  end

end
