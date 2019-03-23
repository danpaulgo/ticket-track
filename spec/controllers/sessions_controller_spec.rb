require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  include_context "fixtures"
  # binding.pry
  let(:valid_login) {
  	{email: admin.email, password: "password"}
  }

  let(:invalid_user) {
  	{email: "nouser@aol.com", password: "password"}
  }

  let(:invalid_password) {
  	{email: admin.email, password: "wordpass"}
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

  describe "POST #create" do
  	context "with logged in user" do
	  	it "redirects user to their own show page" do
	  		admin.reload
	  		post :create, params: {session: valid_login}, session: logged_in_session
	      expect(response).to redirect_to(user)
	      post :create, params: {session: invalid_user}, session: logged_in_session
	      expect(response).to redirect_to(user)
	      post :create, params: {session: invalid_password}, session: logged_in_session
	      expect(response).to redirect_to(user)
	  	end
	  end
	  context "with logged out user" do
  		it "returns success response with valid credentials" do
  			
  			post :create, params: {session: valid_login}, session: logged_out_session
	      expect(response).to redirect_to(admin)
  		end

  		it "re-renders login page with invalid credentials" do
  			post :create, params: {session: invalid_user}, session: logged_out_session
	      expect(response).to render_template(:new)
	      post :create, params: {session: invalid_password}, session: logged_out_session
	      expect(response).to render_template(:new)
  		end
  	end
  end

	describe "DELETE #destroy" do
		it "clears all session data" do
			delete :destroy, session: logged_in_session
			expect(response).to redirect_to(root_path)
			expect(session).to be_empty
		end
	end

end
