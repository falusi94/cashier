# frozen_string_literal: true

FactoryBot.define do
  factory :pricing_rule, class: 'Pricing::BasePricingRule' do
    initialize_with { new(attributes[:name], attributes[:item], **attributes.except(:name, :item)) }

    sequence(:name) { |i| "Pricing rule #{i}" }
    item            { nil }
  end

  factory :get_one_free_after_n_rule, parent: :pricing_rule, class: 'Pricing::GetOneFreeAfterN' do
    after_count { 2 }
  end

  factory :price_discount_after_n_rule, parent: :pricing_rule, class: 'Pricing::PriceDiscountAfterN' do
    after_count        { 2 }
    amount_of_discount { 1 }
  end

  factory :price_drop_after_n_rule, parent: :pricing_rule, class: 'Pricing::PriceDropAfterN' do
    after_count         { 2 }
    discount_multiplier { 0.5 }
  end
end
