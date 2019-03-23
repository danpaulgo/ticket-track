require 'rails_helper'

RSpec.describe PerformersController, type: :controller do

	include_context "fixtures"

	describe "GET #index" do
    it "returns a success response for logged in user" do
      get :index, params: {}, session: user_session
      expect(response).to be_successful
    end

    it "redirects logged out users to home page" do
      get :index, params: {}, session: logged_out_session
      expect(response).to redirect_to(root_path)
    end
  end

end
