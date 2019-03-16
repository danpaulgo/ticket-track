require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
	
	include_context "fixtures"

	describe "GET #home" do
    it "returns a success response for logged out user" do
      get :home, session: {user_id: nil}
      expect(response).to be_successful
    end

    it "redirects to user show page for logged in user" do
    	get :home, session: {user_id: user.id}
    	expect(response).to redirect_to user
    end
  end
end