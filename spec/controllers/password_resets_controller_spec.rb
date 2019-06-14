require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do

	include_context "fixtures"

	describe "GET #new" do
    it "redirects to user show page if logged in" do
    	get :new, params: {}, session: logged_in_session
    	expect(response).to redirect_to(user)
    end

    it "renders new password reset page if logged out" do
    	get :new, params: {}, session: logged_out_session
    	expect(response).to render_template(:new)
    end
  end

	describe "GET #edit" do
    it "does something" do
    	
    end
  end

  describe "GET #create" do
    it "does something" do
    	
    end
  end

  describe "GET #update" do
    it "does something" do
    	
    end
  end

end
