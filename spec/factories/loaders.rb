# frozen_string_literal: true

FactoryBot.define do
  factory :loader do
    trait :with_product do
      after(:create) do |loader|
        create(:product, loader: loader)
      end
    end
  end
end
