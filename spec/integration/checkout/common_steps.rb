# frozen_string_literal: true

steps_for :checkout do
  attr_reader :green_tea, :strawberries, :coffee, :checkout

  step 'a setup with basic items and pricing rules' do
    @green_tea    = build(:green_tea)
    @strawberries = build(:strawberries)
    @coffee       = build(:coffee)
    pricing_rules = [
      build(:get_one_free_after_n_rule, item: green_tea),
      build(:price_discount_after_n_rule, item: strawberries, amount_of_discount: 0.5, after_count: 3),
      build(:price_drop_after_n_rule, item: coffee, discount_multiplier: 1.0 / 3, after_count: 3)
    ]
    @checkout = Checkout.new(pricing_rules)
  end

  step 'add green tea into the cart' do
    @checkout.scan(green_tea)
  end

  step 'add strawberries into the cart' do
    @checkout.scan(strawberries)
  end

  step 'add coffee into the cart' do
    @checkout.scan(coffee)
  end

  step 'the total is :total' do |total|
    expect(checkout.total).to eq(total.to_f)
  end
end
