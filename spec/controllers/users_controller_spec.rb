require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe UsersController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  include_context "fixtures"
  let(:valid_attributes) {
    {name: "Valid User", email: "valid@gmail.com", password: "password", birthdate: "1993-06-18"}
  }

  let(:invalid_attributes) {
    {name: "", email: "invalid", password: "foo", birthdate: nil}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  
  

  describe "GET #index" do
    context "admin" do
      it "returns a success response" do
        get :index, params: {}, session: admin_session
        expect(response).to render_template(:index)
      end
    end

    context "logged in non-admin" do
      it "redirects to users own show page" do
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

  describe "GET #show" do
    context "admin" do
      it "returns a success response" do
        get :show, params: {id: user.to_param}, session: admin_session
        expect(response).to render_template(:show)
      end
    end

    context "logged in non-admin" do
      it "returns a success response when viewing own page" do
        get :show, params: {id: user.to_param}, session: logged_in_session
        expect(response).to render_template(:show)
      end

      it "redirects to own show page when requesting another users show page" do
        get :show, params: {id: admin.to_param}, session: logged_in_session
        expect(response).to redirect_to(user)
      end
    end

    context "logged out user" do
      it "redirects to home page" do
        get :show, params: {id: user.to_param}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #new" do
    context "logged out user" do
      it "returns a success response" do
        get :new, params: {}, session: logged_out_session
        expect(response).to render_template(:new)
      end
    end

    context "logged in user" do 
      it "redirects to their own show page" do
        get :new, params: {}, session: logged_in_session
        expect(response).to redirect_to(user)
        get :new, params: {}, session: admin_session
        expect(response).to redirect_to(admin)
      end
    end
  end

  describe "GET #edit" do
    context "admin" do 
      it "returns a success response" do
        get :edit, params: {id: user.to_param}, session: admin_session
        expect(response).to render_template(:edit)
      end
    end

    context "logged in non-admin" do
      it "returns a success response when editing self" do
        get :edit, params: {id: user.to_param}, session: logged_in_session
        expect(response).to render_template(:edit)
      end

      it "redirects to own edit page when requesting another users edit page" do
        get :edit, params: {id: admin.to_param}, session: logged_in_session
        expect(response).to redirect_to(user)
      end
    end

    context "logged out user" do
      it "redirects to home page" do
        get :edit, params: {id: user.to_param}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    context "with logged in user" do
      it "does not create user" do
        user
        expect {
          post :create, params: {user: valid_attributes}, session: logged_in_session
        }.not_to change(User, :count)
      end

      it "redirects to user's show page" do
        post :create, params: {user: valid_attributes}, session: logged_in_session
        expect(response).to redirect_to(user)
      end
    end

    context "with logged out user" do
      context "with valid params" do
        it "creates a new User" do
          expect {
            post :create, params: {user: valid_attributes}, session: logged_out_session
          }.to change(User, :count).by(1)
          expect(User.last.name).to eq("Valid User")
        end

        it "automatically sets admin to false" do
          post :create, params: {user: valid_attributes}, session: logged_out_session
          expect(User.last.admin).to be(false)
        end

        it "redirects to the created user" do
          post :create, params: {user: valid_attributes}, session: logged_out_session
          expect(response).to redirect_to(User.last)
        end
      end


      context "with invalid params" do
        it "renders 'new' page" do
          post :create, params: {user: invalid_attributes}, session: logged_out_session
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe "PATCH #update" do
    
    context "with valid params" do
      let(:new_attributes) { 
        {name: "New Name", birthdate: "2010-01-01", password: "password"}
      }

      it "allows user to update themself" do
        patch :update, params: {id: user.to_param, user: new_attributes}, session: logged_in_session
        user.reload
        expect(response).to redirect_to(user)
        expect(user.name).to eq("New Name")
        expect(user.birthdate).to eq("20100101".to_date)
      end

      it "allows admin to update any user" do
        patch :update, params: {id: user.to_param, user: new_attributes}, session: admin_session
        user.reload
        expect(response).to redirect_to(user)
        expect(user.name).to eq("New Name")
        expect(user.birthdate).to eq("20100101".to_date)
      end

      it "does not allow non-admin to update users other than themself" do
        patch :update, params: {id: admin.to_param, user: new_attributes}, session: logged_in_session
        user.reload
        expect(response).to redirect_to(user)
        expect(user.name).to eq("John Doe")
      end

      it "redirects logged out user to home page" do
        patch :update, params: {id: user.to_param, user: new_attributes}, session: logged_out_session
        expect(response).to redirect_to(root_path)
        expect(user.name).to eq("John Doe")
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        patch :update, params: {id: user.to_param, user: invalid_attributes}, session: logged_in_session
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    context "admin" do 
      it "allows to delete any user" do
        delete :destroy, params: {id: user.to_param}, session: admin_session
        expect(session[:user_id]).to eq(admin.id)
        expect(User.all).not_to include(user)
        expect(response).to redirect_to(users_path)
      end
    end

    context "logged in non-admin" do
      it "allows to delete themself" do
        delete :destroy, params: {id: user.to_param}, session: logged_in_session
        expect(session[:user_id]).to be_nil
        expect(User.all).not_to include(user)
        expect(response).to redirect_to(root_path)
      end

      it "does not allow to delete another users account" do
        delete :destroy, params: {id: admin.to_param}, session: logged_in_session
        expect(session[:user_id]).to eq(user.id)
        expect(User.all).to include(admin)
        expect(response).to redirect_to(user)
      end
    end

    context "logged out user" do 
      it "does not allow to delete any user" do 
        delete :destroy, params: {id: user.to_param}, session: logged_out_session
        expect(User.all).to include(user)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end