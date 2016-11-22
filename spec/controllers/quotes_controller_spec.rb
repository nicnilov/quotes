require 'rails_helper'

RSpec.describe QuotesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:quote)).to be_present
    end
  end

end
