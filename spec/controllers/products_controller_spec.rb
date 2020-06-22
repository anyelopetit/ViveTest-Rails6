# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do
    before do
      get :index
    end

    it "200 - Ok" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET #show" do
    let(:product) { create(:product) }
    before do
      get :show, params: { id: product.to_param }
    end

    it "200 - Ok" do
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    let(:loader) { create(:loader) }
    let(:payload) {
      [
        {
          name: 'Tenis Nike',
          description: 'Tenis Nike para correr, última generación.',
          variants: [
            { name: 'Talla 32', price: 15000 },
            { name: 'Talla 34', price: 12344.2 }
          ]
        }
      ]
    }

    before do
      post :create, params: payload

      it "201 - Created" do
        expect(response.status).to eq(201)
      end
    end

    context "without product name" do
      let(:payload) { payload.first.merge!(name: '') }
    end

    context "without description" do
      let(:payload) { payload.first.merge!(description: '') }
    end

    context "without varians" do
      let(:payload) { payload.variants.merge!(variants: []) }
    end

    context "with a valid payload"
  end
end
