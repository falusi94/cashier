# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    initialize_with { Item.parse(**attributes) }
  end

  factory :green_tea, parent: :item do
    product_number { 'gr1' }
    name           { 'Green tea' }
    price          { 3.11 }
  end

  factory :strawberries, parent: :item do
    product_number { 'sr1' }
    name           { 'Strawberries' }
    price          { 5 }
  end

  factory :coffee, parent: :item do
    product_number { 'cf1' }
    name           { 'Coffee' }
    price          { 11.23 }
  end
end
