require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do

	include_context "fixtures"

	let(:valid_attributes) {
    {password: "wordpass", password_confirmation: "wordpass"}
  }

  let(:invalid_attributes) {
    {password: "short", password_confirmation: ""}
  }

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
		before(:each){ user.create_reset_digest }

    it "redirects to user show page if logged in" do
    	get :edit, params: {id: user.reset_token, email: user.email}, session: logged_in_session
    	expect(response).to redirect_to(user)
    end

    it "redirect to new reset form with invalid email" do
    	get :edit, params: {id: user.reset_token, email: "invalid"}, session: logged_out_session
    	expect(response).to redirect_to(new_password_reset_path)
    end

    it "redirect to root path with invalid token" do
    	get :edit, params: {id: "invalid", email: user.email}, session: logged_out_session
    	expect(response).to redirect_to(root_path)
    end

    it "renders edit page with valid credentials" do
    	get :edit, params: {id: user.reset_token, email: user.email}, session: logged_out_session
    	expect(response).to render_template(:edit)
    end
  end

  describe "GET #create" do
  	it "redirects to user show page if logged in" do
    	post :create, params: {email: user.email}, session: logged_in_session
    	expect(response).to redirect_to(user)
    end

    it "redirects to root path with valid email" do
    	post :create, params: {email: user.email}, session: logged_out_session
    	expect(response).to redirect_to(root_path)
    end

    it "renders 'new' template with invalid email" do
    	post :create, params: {email: "invalid"}, session: logged_out_session
    	expect(response).to render_template(:new)
    end
  end

  describe "GET #update" do

  	before(:each){ user.create_reset_digest }

    it "redirects to user show page if logged in" do
    	patch :update, params: {id: user.reset_token, email: user.email, user: valid_attributes}, session: logged_in_session
    	expect(response).to redirect_to(user)
    end

    it "redirect to new reset form with invalid email" do
    	patch :update, params: {id: user.reset_token, email: "invalid", user: valid_attributes}, session: logged_out_session
    	expect(response).to redirect_to(new_password_reset_path)
    end

    it "redirect to root path with invalid token" do
    	patch :update, params: {id: "invalid", email: user.email, user: valid_attributes}, session: logged_out_session
    	expect(response).to redirect_to(root_path)
    end

    it "renders edit page with invalid attributes" do
    	patch :update, params: {id: user.reset_token, email: user.email, user: invalid_attributes}, session: logged_out_session
    	expect(response).to render_template(:edit)
    end

    it "redirects to login page with valid credentials" do
    	patch :update, params: {id: user.reset_token, email: user.email, user: valid_attributes}, session: logged_out_session
    	expect(response).to redirect_to(login_path)
    end
  end

end
