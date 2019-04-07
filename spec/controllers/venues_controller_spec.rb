require 'rails_helper'

RSpec.describe VenuesController, type: :controller do

  include_context "fixtures"
  let(:valid_attributes) {
    {name: "Staples Center", city: "Los Angeles", state: "CA"}
  }

  let(:invalid_attributes) {
    {name: "", city: "Boston", state: nil}
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
        get :show, params: {id: venue.id}, session: logged_in_session
        expect(response).to be_successful
      end
    end

    context "logged out user" do
      it "redirects to home page" do
        get :show, params: {id: venue.id}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #new" do
    context "logged in user" do
      it "returns a success response" do
        get :new, params: {id: venue.id}, session: logged_in_session
        expect(response).to be_successful
      end
    end

    context "logged out user" do
      it "redirects to home page" do
        get :new, params: {id: venue.id}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #edit" do
    context "admin" do
      it "returns a success response" do
        get :edit, params: {id: venue.id}, session: admin_session
        expect(response).to be_successful
      end
    end

    context "logged in non admin" do
      it "redirects to user's show page" do
        get :edit, params: {id: venue.id}, session: logged_in_session
        expect(response).to redirect_to(user)
      end
    end

    context "logged out user" do
      it "redirects to home page" do 
        get :edit, params: {id: venue.id}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    context "logged in user" do
      context "with valid attributes" do
        it "creates venue" do
          expect {
            post :create, params: {venue: valid_attributes}, session: logged_in_session
          }.to change(Venue, :count).by(1)
          expect(Venue.last.name).to eq("Staples Center")
        end

        it "redirects to created venue" do
          post :create, params: {venue: valid_attributes}, session: logged_in_session
          expect(response).to redirect_to(Venue.last)
        end

      end

      context "with invalid attributes" do
        it "renders 'new' page" do
           expect(response).to render_template(:new)
        end
      end
    end

    context "logged out user" do
      it "redirects to home page" do
        post :create, params: {id: venue.id, venue: valid_attributes}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH #update" do
    context "admin" do
      context "with valid attributes" do
        before(:each) do 
          patch :update, params: {id: venue.id, venue: valid_attributes}, session: admin_session
        end

        it "updates venue" do
          venue.reload
          expect(venue.name).to eq("Drizzy Drake")
        end

        it "redirects to venue page" do
          expect(response).to redirect_to(venue)
        end
      end

      context "with invalid attributes" do
        it "renders edit page" do
          post :update, params: {id: venue.id, venue: invalid_attributes}, session: admin_session
          expect(response).to render_template(:edit)
        end
      end
    end

    context "logged in non admin" do
      before(:each) do 
        patch :update, params: {id: venue.id, venue: valid_attributes}, session: logged_in_session
      end

      it "redirects to user's show page" do
        expect(response).to redirect_to(user)
      end

      it "does not update venue" do
        expect(venue.name).to eq("Drake")
      end
    end

    context "logged out user" do 
      before(:each) do 
        patch :update, params: {id: venue.id, venue: valid_attributes}, session: logged_out_session
      end

      it "redirect to home page" do
        patch :update, params: {id: venue.id, venue: valid_attributes}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end

      it "does not update venue" do
        expect(venue.name).to eq("Drake")
      end
    end
  end

  describe "DELETE #destroy" do
    context "admin" do
      context "with valid venue id"
        before(:each) do 
          delete :destroy, params: {id: venue.id}, session: admin_session
        end
        it "successfully deletes venue" do
          expect(Venue.all).not_to include(venue)
        end
        it "redirects to venues index" do
          expect(response).to redirect_to(venues_path)
        end
      end

      context "with invalid venue id" do
        it "does not delete any venues" do
          venue
          expect {
            delete :destroy, params: {id: 99}, session: admin_session
          }.not_to change(venue, :count)
        end
        it "redirects to venues index" do
          delete :destroy, params: {id: 99}, session: admin_session
          expect(response).to redirect_to(venues_path)
        end
      end

    context "logged in non admin" do
      it "does not delete venue" do
        delete :destroy, params: {id: venue.id}, session: logged_in_session
        expect(Venue.all).to include(venue)
      end
      it "redirects to user's show page" do
        delete :destroy, params: {id: venue.id}, session: logged_in_session
        expect(response).to redirect_to(user)
      end
    end

    context "logged out user" do
      it "does not delete venue" do
        delete :destroy, params: {id: venue.id}, session: logged_out_session
        expect(Venue.all).to include(venue)
      end
      it "redirects to home page" do
        delete :destroy, params: {id: venue.id}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
