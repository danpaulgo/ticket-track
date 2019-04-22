require "rails_helper"

RSpec.describe TransactionSourcesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/transaction_sources").to route_to("transaction_sources#index")
    end

    it "routes to #edit" do
      expect(:get => "/transaction_sources/1/edit").to route_to("transaction_sources#edit", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/transaction_sources/1").to route_to("transaction_sources#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/transaction_sources/1").to route_to("transaction_sources#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/transaction_sources/1").to route_to("transaction_sources#destroy", :id => "1")
    end
  end
end
