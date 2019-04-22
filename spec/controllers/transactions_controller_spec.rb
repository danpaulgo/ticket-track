require 'rails_helper'



RSpec.describe TransactionsController, type: :controller do

  include_context "fixtures"

  let(:valid_attributes) {
    {
      event_id: event_2.id, 
      amount: 200, direction: "Purchase", 
      quantity: 4, 
      order_number: "testing123",
      transaction_source_id: stubhub.id
    }
  }

  let(:invalid_attributes) {
    {
      event_id: 0, 
      amount: 200, direction: "buy", 
      quantity: 0, 
      order_number: 1234,
      transaction_source_id: 0
    }
  }

  describe "GET #index" do
    context "admin" do
      it "renders index without user_id" do
        get :index, params: {}, session: admin_session
        expect(response).to render_template(:index)
      end

      it "renders index with any user_id" do
        get :index, params: {user_id: user.id}, session: admin_session
        expect(response).to render_template(:index)
      end
    end

    context "logged in user" do
      it "renders index with own user_id" do
        get :index, params: {user_id: user.id}, session: logged_in_session
        expect(response).to render_template(:index)
      end

      it "redirects to users show page with other user_id" do
        get :index, params: {user_id: admin.id}, session: logged_in_session
        expect(response).to redirect_to(user)
      end

      it "redirects to users show page without user_id" do
        get :index, params: {}, session: logged_in_session
        expect(response).to redirect_to(user)
      end
    end

    context "logged out user" do
      it "redirects to home page" do
        get :index, params: {}, session: logged_out_session
        expect(response).to redirect_to(root_path)
        get :index, params: {user_id: user.id}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #new" do
    context "logged in user" do
      it "renders new template with correct user_id" do
        get :new, params: {user_id: user.id}, session: logged_in_session
        expect(response).to render_template(:new)
      end

      it "redirects to user's show page with incorrect user_id" do
        get :new, params: {user_id: admin.id}, session: logged_in_session
        expect(response).to redirect_to(user)
      end

      it "redirects to user's show page without user_id" do
        get :new, params: {}, session: logged_in_session
        expect(response).to redirect_to(user)
      end
    end

    context "logged out user" do
      it "redirects to home page" do
        get :new, params: {}, session: logged_out_session
        expect(response).to redirect_to(root_path)
        get :new, params: {user_id: user.id}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #edit" do
    context "admin" do
      context "with valid transaction id" do
        it "renders edit template with matching user_id" do
          get :edit, params: {user_id: user.id, id: purchase.id}, session: admin_session
          expect(response).to render_template(:edit)
        end

        it "redirects to admin show page with non-matching user_id" do
          get :edit, params: {user_id: admin.id, id: purchase.id}, session: admin_session
          expect(response).to redirect_to(admin)
        end

        it "redirects to admin show page without user_id" do
          get :edit, params: {id: purchase.id}, session: admin_session
          expect(response).to redirect_to(admin)
        end
      end

      context "with invalid transaction id" do
        it "redirects to admin show page" do 
          get :edit, params: {id: 0}, session: admin_session
          expect(response).to redirect_to(admin)
        end
      end
    end

    context "logged in non admin" do
      context "with own user_id and transaction" do
        it "renders edit template" do
          get :edit, params: {user_id: user.id, id: purchase.id}, session: logged_in_session
          expect(response).to render_template(:edit)
        end
      end

      context "other user's id" do
        it "redirects to user's show page" do
          get :edit, params: {user_id: admin.id, id: purchase.id}, session: logged_in_session
          expect(response).to redirect_to(user)
        end
      end

      context "no user_id" do
        it "redirects to user's show page" do
          get :edit, params: {id: purchase.id}, session: logged_in_session
          expect(response).to redirect_to(user)
        end
      end

      context "with invalid transaction id" do
        it "redirects to user's show page" do
          get :edit, params: {user_id: user.id, id: 0}, session: logged_in_session
          expect(response).to redirect_to(user)
        end
      end
    end

    context "logged out user" do
      it "redirects to home page" do 
        get :edit, params: {user_id: user.id, id: purchase.id}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    context "logged in user" do
      context "with valid attributes" do
        context "with matching user id" do
          it "creates new transaction" do
            expect {
              post :create, params: {user_id: user.id, transaction: valid_attributes}, session: logged_in_session
            }.to change(Transaction, :count).by(1)
            expect(Transaction.last.order_number).to eq("testing123")
          end

          it "redirects to user's transaction index" do
            post :create, params: {user_id: user.id, transaction: valid_attributes}, session: logged_in_session
            expect(response).to redirect_to(user_transactions_path(user))
          end
        end

        context "with non matching user id" do
          it "redirects to user's show page" do
            post :create, params: {user_id: admin.id, transaction: valid_attributes}, session: logged_in_session
            expect(response).to redirect_to(user)
          end

          it "does not create new transaction" do
            expect {
              post :create, params: {user_id: user.id, transaction: valid_attributes}, session: logged_in_session
            }.not_to change(Transaction, :count)
          end
        end
      end
      context "with invalid attributes" do
        it "renders 'new' template" do
          post :create, params: {user_id: user.id, transaction: invalid_attributes}, session: logged_in_session
          expect(response).to render_template(:new)
        end
      end
    end

    context "logged out user" do
      it "does not create transaction source" do
        expect {
          post :create, params: {user_id: user.id, transaction: valid_attributes}, session: logged_out_session
        }.not_to change(Transaction, :count)
      end

      it "redirects to home page" do
        post :create, params: {user_id: admin.id, transaction: valid_attributes}, session: logged_in_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH #update" do
    context "admin" do
      context "with valid attributes" do
        context "with matching user id" do
          before(:each) do 
    
          end
         
          it "successfully updates transaction" do

          end

          it "redirects to transactions index" do

          end
        end

        context "with non-matching user id" do
          it "redirects to admin's show page" do

          end

          it "does not update transaction" do

          end
        end
      end
      context "with invalid attributes" do
        it "renders edit page" do
          
        end
      end
    end

    context "logged in non admin" do
      before(:each) do 
    
      end

      it "redirects to user's show page" do
        
      end

      it "does not update transaction" do
        
      end
    end

    context "logged out user" do 
      before(:each) do 
    
      end

      it "redirect to home page" do
        
      end

      it "does not update transaction" do
        
      end
    end
  end

  describe "DELETE #destroy" do
    context "admin" do
      context "with valid transaction id" do
        context "with matching user id" do
          before(:each) do 
            delete :destroy, params: {id: venue.id}, session: admin_session
          end

          it "successfully deletes venue" do
            
          end

          it "redirects to transactions index" do
            
          end
        end
        context "with non-matching user id" do
          it "redirects to admin's show page" do

          end

          it "does not delete transaction" do

          end
        end
      end

      context "with invalid transaction id" do
        it "does not delete any transactions" do
          
        end

        it "redirects to admin's show page" do
          
        end
      end
    end

    context "logged in non admin" do
      it "does not delete transaction" do
        
      end

      it "redirects to user's show page" do
        
      end
    end

    context "logged out user" do
      it "does not delete transaction" do
        
      end

      it "redirects to home page" do
        
      end
    end
  end

end
