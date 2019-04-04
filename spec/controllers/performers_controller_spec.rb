require 'rails_helper'

RSpec.describe PerformersController, type: :controller do

	include_context "fixtures"
	 let(:valid_attributes) {
    {name: "Drizzy Drake"}
  }

  let(:invalid_attributes) {
    {name: ""}
  }

	describe "GET #index" do
		context "logged in user" do
	    it "returns a success response" do
	      get :index, params: {}, session: logged_in_session
	      expect(response).to be_successful
	    end
	  end

	  context "logged out user" do
	    it "redirects to home page" do
	      get :index, params: {}, session: logged_out_session
	      expect(response).to redirect_to(root_path)
	    end
	  end
  end

  describe "GET #show" do
  	context "logged in user" do
	    it "returns a success response" do
	      get :show, params: {id: performer.id}, session: logged_in_session
	      expect(response).to be_successful
	    end
	  end

	  context "logged out user" do
	    it "redirects to home page" do
	      get :show, params: {id: performer.id}, session: logged_out_session
	      expect(response).to redirect_to(root_path)
	    end
	  end
  end

  describe "GET #edit" do
  	context "admin" do
  		it "returns a success response" do
	      get :edit, params: {id: performer.id}, session: admin_session
	      expect(response).to be_successful
	    end
  	end

  	context "non admin" do
  		it "redirects to home page" do
	      get :edit, params: {id: performer.id}, session: logged_in_session
	      expect(response).to redirect_to(root_path)
	      get :edit, params: {id: performer.id}, session: logged_out_session
	      expect(response).to redirect_to(root_path)
	    end
  	end
  end

  describe "POST #update" do
  	context "admin with valid attributes" do
  		before(:each) do 
  			post :update, params: {id: performer.id, performer: valid_attributes}, session: admin_session
  		end

  		it "updates performer" do
	      expect(performer.name).to eq("Drizzy Drake")
	    end

	    it "returns success response" do
	    	expect(response).to be_successful
	    end
	  end

	  context "admin with invalid attributes" do
	    it "renders edit page" do
	    	post :update, params: {id: performer.id, performer: invalid_attributes}, session: admin_session
	      expect(response).to be_successful
	    end
  	end

  	context "non admin" do
  		it "redirects to home page" do
	      get :edit, params: {id: performer.id}, session: logged_in_session
	      expect(response).to redirect_to(root_path)
	      get :edit, params: {id: performer.id}, session: logged_out_session
	      expect(response).to redirect_to(root_path)
	    end
  	end
  end

end
