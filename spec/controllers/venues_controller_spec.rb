require 'rails_helper'

RSpec.describe VenuesController, type: :controller do

  include_context "fixtures"
  let(:valid_attributes) {
    {name: "Staples Center", city: "Los Angeles", state: "CA"}
  }

  let(:invalid_attributes) {
    {name: "", city: "Boston", state: nil}
  }

end
