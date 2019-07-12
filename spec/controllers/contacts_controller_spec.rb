require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  include_context "fixtures"
  let(:valid_attributes) {
    {email: "admin@gmail.com", subject: "Valid", message: "These are valid attributes"}
  }

  let(:invalid_attributes) {
    {email: "invalid", subject: "", message: nil}
  }

  describe "GET #new" do
    it "renders new template for any user" do
      get :new, params: {}, session: admin_session
      expect(response).to render_template(:new)
      get :new, params: {}, session: logged_out_session
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "redirects to root path" do
        post :create, params: {contact: valid_attributes}, session: logged_out_session
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid attributes" do
      it "renders new contact template" do
        post :create, params: {contact: invalid_attributes}, session: logged_in_session
        expect(response).to render_template(:new)
      end
    end
  end

end