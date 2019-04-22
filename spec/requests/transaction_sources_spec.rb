require 'rails_helper'

RSpec.describe "TransactionSources", type: :request do
  describe "GET /transaction_sources" do
    it "works! (now write some real specs)" do
      get transaction_sources_path
      expect(response).to have_http_status(200)
    end
  end
end
