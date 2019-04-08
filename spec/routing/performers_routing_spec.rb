require "rails_helper"

RSpec.describe PerformersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/performers").to route_to("performers#index")
    end

    it "routes to #show" do
      expect(:get => "/performers/1").to route_to("performers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/performers/1/edit").to route_to("performers#edit", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/performers/1").to route_to("performers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/performers/1").to route_to("performers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/performers/1").to route_to("performers#destroy", :id => "1")
    end
  end
end
