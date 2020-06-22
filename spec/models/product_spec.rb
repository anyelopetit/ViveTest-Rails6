# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product, regressor: true do
  describe "associations" do
    it { is_expected.to belong_to(:loader).optional(true) }
    it { is_expected.to have_many(:variants) }
  end

  describe "validations" do
    subject { build(:product, loader: create(:loader)) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe ".variants" do
    let(:variant) { { name: 'Talla 32', price: 15000 } }

    it "returns a Hash" do
      expect(variant.class).to eq(Hash)
    end

    it "keys are :name and :price" do
      expect(variant.try(:keys)).to eq(%i[name price])
    end

    it ":name value is an String" do
      expect(variant.dig(:name).class).to eq(String)
    end

    it ":price value is an Float" do
      expect(variant.dig(:price).to_f.class).to eq(Float)
    end
  end
end
