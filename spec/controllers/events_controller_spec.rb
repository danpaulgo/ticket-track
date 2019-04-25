require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  include_context "fixtures"
  let(:valid_attributes) {
    {venue_id: venue_2.id, performer_id: performer_2.id, date: "01-01-2021".to_date}
  }

  let(:invalid_attributes) {
    {venue_id: 0, performer: 99, date: "today"}
  }

  describe "GET #index" do
    context "logged in user" do
      it "renders index template" do
        get :index, params: {}, session: logged_in_session
        expect(response).to render_template(:index)
      end
    end

    context "logged out user" do
      it "redirects to home page" do
        get :index, params: {}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #new" do
    context "logged in user" do
      it "renders new template" do
        get :new, params: {}, session: logged_in_session
        expect(response).to render_template(:new)
      end
    end

    context "logged out user" do
      it "redirects to home page" do
        get :new, params: {}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #edit" do
    context "admin" do
      context "with valid event id" do
        it "renders edit template" do
          get :edit, params: {id: event.id}, session: admin_session
          expect(response).to render_template(:edit)
        end
      end

      context "with invalid event id" do
        it "redirects to admin's show page" do
          get :edit, params: {id: 0}, session: admin_session
          expect(response).to redirect_to(admin)
        end
      end
    end

    context "logged in non admin" do
      it "redirects to user's show page" do
        get :edit, params: {id: event.id}, session: logged_in_session
        expect(response).to redirect_to(user)
      end
    end

    context "logged out user" do
      it "redirects to home page" do 
        get :edit, params: {id: event.id}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    context "logged in user" do
      context "with valid attributes" do
        it "creates event" do
          expect {
            post :create, params: {event: valid_attributes}, session: logged_in_session
          }.to change(Event, :count).by(1)
          expect(Event.last.date).to eq("01-01-2021".to_date)
          expect(Event.last.performer).to eq(performer_2)
        end

        it "redirects to created event" do
          post :create, params: {event: valid_attributes}, session: logged_in_session
          expect(response).to redirect_to(Event.last)
        end

      end

      context "with invalid attributes" do
        it "renders 'new' page" do
          post :create, params: {event: invalid_attributes}, session: logged_in_session
           expect(response).to render_template(:new)
        end
      end
    end

    context "logged out user" do
      it "does not create event" do
        expect {
          post :create, params: {event: valid_attributes}, session: logged_out_session
        }.not_to change(Event, :count)
      end

      it "redirects to home page" do
        post :create, params: {id: event.id, event: valid_attributes}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH #update" do
    context "admin" do
      context "with valid attributes" do
        context "with valid event id" do
          before(:each) do 
            patch :update, params: {id: event.id, event: valid_attributes}, session: admin_session
          end

          it "updates event" do
            event.reload
            expect(event.date).to eq("01-01-2021".to_date)
            expect(event.performer).to eq(performer_2)
            expect(event.venue).to eq(venue_2)
          end

          it "redirects to events index page" do
            expect(response).to redirect_to(events_path)
          end
        end

        context "with invalid event id" do
          it "redirects to admin's show page" do
            patch :update, params: {id: 0, event: valid_attributes}, session: admin_session
            expect(response).to redirect_to(admin)
          end
        end
      end

      context "with invalid attributes" do
        it "renders edit page" do
          post :update, params: {id: event.id, event: invalid_attributes}, session: admin_session
          expect(response).to render_template(:edit)
        end
      end
    end

    context "logged in non admin" do
      before(:each) do 
        patch :update, params: {id: event.id, event: valid_attributes}, session: logged_in_session
      end

      it "redirects to user's show page" do
        expect(response).to redirect_to(user)
      end

      it "does not update event" do
        event.reload
        expect(event.date).to eq(Date.today + 1.year)
        expect(event.venue).to eq(venue)
      end
    end

    context "logged out user" do 
      before(:each) do 
        patch :update, params: {id: event.id, event: valid_attributes}, session: logged_out_session
      end

      it "redirect to home page" do
        patch :update, params: {id: event.id, event: valid_attributes}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end

      it "does not update event" do
        event.reload
        expect(event.date).to eq(Date.today + 1.year)
        expect(event.venue).to eq(venue)
      end
    end
  end

  describe "DELETE #destroy" do
    context "admin" do
      context "with valid event id"
        before(:each) do 
          delete :destroy, params: {id: event.id}, session: admin_session
        end
        it "successfully deletes event" do
          expect(Event.all).not_to include(event)
        end
        it "redirects to events index" do
          expect(response).to redirect_to(events_path)
        end
      end

      context "with invalid event id" do
        it "does not delete any events" do
          event
          expect {
            delete :destroy, params: {id: 99}, session: admin_session
          }.not_to change(Event, :count)
        end
        it "redirects to admin's show page" do
          delete :destroy, params: {id: 99}, session: admin_session
          expect(response).to redirect_to(admin)
        end
      end

    context "logged in non admin" do
      it "does not delete event" do
        delete :destroy, params: {id: event.id}, session: logged_in_session
        expect(Event.all).to include(event)
      end
      it "redirects to user's show page" do
        delete :destroy, params: {id: event.id}, session: logged_in_session
        expect(response).to redirect_to(user)
      end
    end

    context "logged out user" do
      it "does not delete event" do
        delete :destroy, params: {id: event.id}, session: logged_out_session
        expect(Event.all).to include(event)
      end
      it "redirects to home page" do
        delete :destroy, params: {id: event.id}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
