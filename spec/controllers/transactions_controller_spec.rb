require 'rails_helper'



RSpec.describe TransactionsController, type: :controller do

  include_context "fixtures"

  let(:valid_attributes) {
    {
      event_id: event_2.id, 
      amount: 200, direction: "Purchase", 
      quantity: 4, 
      order_number: "testing123",
      transaction_source_id: stubhub.id,
      date: "01-01-2019".to_date
    }
  }

  let(:invalid_attributes) {
    {
      event_id: 0, 
      amount: 200, direction: "buy", 
      quantity: 0, 
      order_number: 1234,
      transaction_source_id: 0,
      date: "01-01-2030".to_date
    }
  }

  describe "GET #index" do
    context "admin" do
      it "redirects to admin's show page without user_id" do
        get :index, params: {}, session: admin_session
        expect(response).to redirect_to(admin)
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
              post :create, params: {user_id: admin.id, transaction: valid_attributes}, session: logged_in_session
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
        post :create, params: {user_id: admin.id, transaction: valid_attributes}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH #update" do
    context "admin" do
      context "with valid attributes" do
        context "with matching user id" do
          before(:each) do 
            patch :update, params: {id: purchase.id, user_id: user.id, transaction: valid_attributes}, session: admin_session
          end
         
          it "successfully updates transaction" do
            purchase.reload
            expect(purchase.order_number).to eq("testing123")
          end

          it "redirects to transactions index" do
            expect(response).to redirect_to(transactions_path)
          end
        end

        context "with non-matching user id" do
          before(:each) do 
            patch :update, params: {id: purchase.id, user_id: 0, transaction: valid_attributes}, session: admin_session
          end

          it "redirects to admin's show page" do
            expect(response).to redirect_to(admin)
          end

          it "does not update transaction" do
            purchase.reload
            expect(purchase.order_number).to eq("1234567")
          end
        end
      end
      context "with invalid attributes" do
        it "renders edit page" do
          patch :update, params: {id: purchase.id, user_id: user.id, transaction: invalid_attributes}, session: admin_session
          expect(response).to render_template(:edit)
        end
      end
    end

    context "logged in non admin" do
      context "updating own transaction" do
        before(:each) do 
          patch :update, params: {id: purchase.id, user_id: user.id, transaction: valid_attributes}, session: logged_in_session
        end

        it "redirects to user's transactions page" do
          expect(response).to redirect_to(user_transactions_path(user))
        end

        it "successfully updates transaction" do
          purchase.reload
          expect(purchase.order_number).to eq("testing123")
        end
      end

      context "attempting to update another users transaction" do
        before(:each) do 
          patch :update, params: {id: admin_sale.id, user_id: admin.id, transaction: valid_attributes}, session: logged_in_session
        end

        it "redirects to user's show page" do
          expect(response).to redirect_to(user)
        end

        it "does not update transaction" do
          purchase.reload
          expect(purchase.order_number).to eq("1234567")
        end
      end
    end

    context "logged out user" do 
      before(:each) do 
        patch :update, params: {id: purchase.id, user_id: user.id, transaction: valid_attributes}, session: logged_out_session
      end

      it "redirect to home page" do
        expect(response).to redirect_to(root_path)
      end

      it "does not update transaction" do
        expect(purchase.order_number).to eq("1234567")
      end
    end
  end

  describe "DELETE #destroy" do
    context "admin" do
      context "with valid transaction id" do
        context "with matching user id" do
          before(:each) do 
            delete :destroy, params: {id: sale.id, user_id: user.id}, session: admin_session
          end

          it "successfully deletes transaction" do
            expect(Transaction.all).not_to include(sale)
          end

          it "redirects to transactions index" do
            expect(response).to redirect_to(transactions_path)
          end
        end
        context "with non-matching user id" do
          it "redirects to admin's show page" do
            delete :destroy, params: {id: sale.id, user_id: admin.id}, session: admin_session
          end

          it "does not delete transaction" do
            sale
            expect {
              delete :destroy, params: {id: sale.id, user_id: admin.id}, session: admin_session
            }.not_to change(Transaction, :count)
          end
        end
      end

      context "with invalid transaction id" do
        it "does not delete any transactions" do
          expect {
            delete :destroy, params: {id: 0, user_id: admin.id}, session: admin_session
          }.not_to change(Transaction, :count)
        end

        it "redirects to admin's show page" do
          delete :destroy, params: {id: 0, user_id: admin.id}, session: admin_session
          expect(response).to redirect_to(admin)
        end
      end
    end

    context "logged in non admin" do
      context "deleting own transaction" do
        before(:each) do 
          delete :destroy, params: {id: sale.id, user_id: user.id}, session: logged_in_session
        end

        it "successfully deletes transaction" do
          expect(Transaction.all).not_to include(sale)
        end

        it "redirects to user's transactions index" do
          expect(response).to redirect_to(user_transactions_path(user))
        end
      end

      context "attempting to delete another user's transaction" do
        it "does not delete transaction" do
          admin_sale
          expect{
            delete :destroy, params: {id: admin_sale.id, user_id: admin.id}, session: logged_in_session
          }.not_to change(Transaction, :count)
        end

        it "redirects to user's show page" do
          delete :destroy, params: {id: admin_sale.id, user_id: admin.id}, session: logged_in_session
          expect(response).to redirect_to(user)
        end
      end
    end

    context "logged out user" do
      it "does not delete any transactions" do
        sale
        expect {
          delete :destroy, params: {id: sale.id, user_id: user.id}, session: logged_out_session
        }.not_to change(Transaction, :count)
      end

      it "redirects to home page" do
        delete :destroy, params: {id: sale.id, user_id: user.id}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
