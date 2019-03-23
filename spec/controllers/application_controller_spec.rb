require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
	
	include_context "fixtures"

	describe "GET #home" do
    it "returns a success response for logged out user" do
      get :home, session: logged_out_session
      expect(response).to be_successful
    end

    it "redirects to user show page for logged in user" do
    	get :home, session: logged_in_session
    	expect(response).to redirect_to user
    end
  end

  describe "current_user" do
    context "with no user logged in" do
      it "returns nil" do
        get :home, session: logged_out_session
        expect(controller.current_user).to be_nil
      end
    end

    context "with user logged in" do
      it "returns user matching the sessions user_id" do
        get :home, session: logged_in_session
        expect(controller.current_user).to eq(user)
      end
    end
  end

  describe "logged_in?" do
    it "returns true if session has a user_id" do
      get :home, session: logged_in_session
      expect(controller.logged_in?).to be(true)
    end

    it "returns false if session does not have a user_id" do
      get :home, session: logged_out_session
      expect(controller.logged_in?).to be(false)
    end
  end

  describe "login" do
    it "adds user to session hash" do
      controller.login(user)
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe "logout" do
    it "clears session hash" do
      get :home, session: logged_in_session
      controller.logout
      expect(session[:user_id]).to be_nil
    end
  end
end