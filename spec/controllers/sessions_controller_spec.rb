require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  include_context "fixtures"
  let(:valid_login) {
  	{email: "danpaulgo@aol.com", password: "password"}
  }

  let(:invalid_user) {
  	{email: "nouser@aol.com", password: "password"}
  }

  let(:invalid_password) {
  	{email: "danpaulgo@aol.com", password: "wordpass"}
  }

  describe "GET #new" do
    it "returns success response for logged out user" do
      get :new, session: logged_out_session
      expect(response).to be_successful
    end

    it "redirects logged in user to their own show page" do
    	 get :new, session: logged_in_session
      expect(response).to redirect_to(user)
    end
  end

end
