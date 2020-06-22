# frozen_string_literal: true

FactoryBot.define do
  factory :varians do
    name { "Talla 32" }
    price { 15000 }
    association :produc
  end
end
