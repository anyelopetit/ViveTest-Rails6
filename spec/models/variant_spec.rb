# frozen_string_literal: true

require "rails_helper"

RSpec.describe Variant, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:product).optional(true) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
  end
end
