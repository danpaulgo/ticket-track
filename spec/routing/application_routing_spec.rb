require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do
    it "routes to home" do
      expect(:get => "/").to route_to("application#home")
    end

    it "routes to about" do
      expect(:get => "/about").to route_to("application#about")
    end

    it "routes to contact" do
      expect(:get => "/contact").to route_to("application#contact")
    end
  end
end
