# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { FFaker::Name.name }
    description { FFaker::Lorem.phrase }
    trait :with_variants do
      after(:create) do |product|
        create(:variant, product: product)
      end
    end
    association :loader, factory: :loader
  end
end
