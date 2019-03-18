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

  describe "current_user" do
    context "with no user logged in" do
      it "returns nil" do
        get :home, session: {user_id: nil}
        expect(controller.current_user).to be_nil
      end
    end

    context "with user logged in" do
      it "returns user matching the sessions user_id" do
        get :home, session: {user_id: user.id}
        expect(controller.current_user).to eq(user)
      end
    end
  end
end