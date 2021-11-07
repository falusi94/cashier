# frozen_string_literal: true

FactoryBot.define do
  factory :pricing_rule, class: 'Pricing::BasePricingRule' do
    initialize_with do
      class_name
        .constantize
        .new(attributes[:name], attributes[:item], **attributes.except(:name, :item))
    end

    sequence(:name) { |i| "Pricing rule #{i}" }

    transient do
      class_name { 'Pricing::BasePricingRule' }
    end
  end

  factory :get_one_free_after_n_rule, parent: :pricing_rule do
    class_name { 'Pricing::GetOneFreeAfterN' }

    item        { nil }
    after_count { 2 }
  end

  factory :price_discount_after_n_rule, parent: :pricing_rule do
    class_name { 'Pricing::PriceDiscountAfterN' }

    item               { nil }
    after_count        { 2 }
    amount_of_discount { 1 }
  end

  factory :price_drop_after_n_rule, parent: :pricing_rule do
    class_name { 'Pricing::PriceDropAfterN' }

    item                { nil }
    after_count         { 2 }
    discount_multiplier { 0.5 }
  end
end
