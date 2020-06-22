# frozen_string_literal: true

require "rails_helper"

RSpec.describe DashboardController, type: :controller do
  describe "GET #index" do
    before do
      get :index
    end

    it "200 - Ok" do
      expect(response.status).to eq(200)
    end
  end
end
