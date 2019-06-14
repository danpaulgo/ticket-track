require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do

	include_context "fixtures"

	describe "GET #edit" do

    it "redirects to homepage with incorrect token" do
    	get :edit, params: {id: "incorrect" , email: inactive_user.email}, session: logged_out_session
      expect(response).to redirect_to(root_path)
    end

    it "redirects to login page with correct token" do
    	get :edit, params: {email: inactive_user.email, id: inactive_user.activation_token,  session: logged_out_session}
    	expect(response).to redirect_to(login_path)
    end

    it "logs user out if logged in" do
    	get :edit, params: {email: inactive_user.email, id: inactive_user.activation_token,  session: logged_out_session}
    	expect(session[:user_id]).to be(nil)
    end
  end

end
