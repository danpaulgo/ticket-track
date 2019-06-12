require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do

	describe "GET #edit" do
    it "renders redirects to homepage" do
      get :edit, params: {id: event.id}, session: admin_session
      expect(response).to render_template("application/home"
    end
  end

end
