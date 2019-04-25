require 'rails_helper'

RSpec.describe TransactionSourcesController, type: :controller do

  include_context "fixtures"
  let(:valid_attributes) {
   {name: "Tickpick"}
  }

  let(:invalid_attributes) {
    {name: ""}
  }

  describe "GET #index" do
    context "admin" do
      it "renders index template" do
        get :index, params: {}, session: admin_session
        expect(response).to render_template(:index)
      end
    end

    context "logged in non admin" do
      it "redirects to user's show page" do
        get :index, params: {}, session: logged_in_session
        expect(response).to redirect_to(user)
      end
    end

    context "logged out user" do
      it "redirects to home page" do
        get :index, params: {}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #edit" do
    context "admin" do
      context "with valid transaction_source id" do
        it "renders edit template" do
          get :edit, params: {id: ticketmaster.id}, session: admin_session
          expect(response).to render_template(:edit)
        end
      end

      context "with invalid transaction_source id" do
        it "redirects to admin show page" do
          get :edit, params: {id: 0}, session: logged_in_session
          expect(response).to redirect_to(admin)
        end
      end
    end

    context "logged in non admin" do
      it "redirects to user page" do
        get :edit, params: {id: ticketmaster.id}, session: logged_in_session
        expect(response).to redirect_to(user)
      end
    end

    context "logged out user" do
      it "redirects to home page" do 
        get :edit, params: {id: ticketmaster.id}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH #update" do
    context "admin" do
      context "with valid attributes" do
        context "with valid transaction_source id" do
          before(:each) do 
            patch :update, params: {id: ticketmaster.id, transaction_source: valid_attributes}, session: admin_session
          end

          it "updates transaction_source" do
            ticketmaster.reload
            expect(ticketmaster.name).to eq("Tickpick")
          end

          it "redirects to transaction_source index" do
            expect(response).to redirect_to(transaction_sources_path)
          end
        end

        context "with invalid transaction_source id" do
          it "redirects to admin's show page" do
            patch :update, params: {id: 0, transaction_source: invalid_attributes}, session: admin_session
            expect(response).to redirect_to(admin)
          end
        end
      end

      context "with invalid attributes" do
        it "renders edit page" do
          patch :update, params: {id: ticketmaster.id, transaction_source: invalid_attributes}, session: admin_session
          expect(response).to render_template(:edit)
        end
      end
    end

    context "logged in non admin" do
      before(:each) do 
        patch :update, params: {id: ticketmaster.id, transaction_source: valid_attributes}, session: logged_in_session
      end

      it "redirects to user's show page" do
        expect(response).to redirect_to(user)
      end

      it "does not update transaction_source" do
        ticketmaster.reload
        expect(transaction_source.name).to eq("Ticketmaster")
      end
    end

    context "logged out user" do 
      before(:each) do 
        patch :update, params: {id: ticketmaster.id, transaction_source: valid_attributes}, session: logged_out_session
      end

      it "redirect to home page" do
        expect(response).to redirect_to(root_path)
      end

      it "does not update transaction_source" do
        ticketmaster.reload
        expect(ticketmaster.name).to eq("Ticketmaster")
      end
    end
  end

  describe "DELETE #destroy" do
    context "admin" do
      context "with valid transaction_source id"
        before(:each) do 
          delete :destroy, params: {id: ticketmaster.id}, session: admin_session
        end

        it "successfully deletes transaction_source" do
          expect(TransactionSource.all).not_to include(ticketmaster)
        end

        it "redirects to transaction_source index" do
          expect(response).to redirect_to(transaction_sources_path)
        end
      end

      context "with invalid transaction_source id" do
        it "does not delete any transaction_sources" do
          ticketmaster
          expect {
            delete :destroy, params: {id: 0}, session: admin_session
          }.not_to change(TransactionSource, :count)
        end

        it "redirects to admin's show page" do
          delete :destroy, params: {id: 0}, session: admin_session
          expect(response).to redirect_to(admin)
        end
      end

    context "logged in non admin" do
      it "does not delete transaction_source" do
        delete :destroy, params: {id: ticketmaster.id}, session: logged_in_session
        expect(TransactionSource.all).to include(ticketmaster)
      end

      it "redirects to user's show page" do
        delete :destroy, params: {id: ticketmaster.id}, session: logged_in_session
        expect(response).to redirect_to(user)
      end
    end

    context "logged out user" do
      it "does not delete transaction_source" do
        delete :destroy, params: {id: ticketmaster.id}, session: logged_out_session
        expect(TransactionSource.all).to include(ticketmaster)
      end
      it "redirects to home page" do
        delete :destroy, params: {id: ticketmaster.id}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
