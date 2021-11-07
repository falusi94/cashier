# frozen_string_literal: true

steps_for :checkout do
  attr_reader :green_tea, :strawberries, :coffee, :checkout

  step 'a setup with basic items and pricing rules' do
    @green_tea    = build(:green_tea)
    @strawberries = build(:strawberries)
    @coffee       = build(:coffee)
    pricing_rules = [
      Pricing::GetOneFreeAfterN.new('Buy-one-get-one-free green tea', green_tea, after_count: 2),
      Pricing::PriceDiscountAfterN.new('Price discount after three strawberries', strawberries,
                                       amount_of_discount: 0.5, after_count: 3),
      Pricing::PriceDropAfterN.new('Price drop after three coffees', coffee,
                                   discount_multiplier: 1.0 / 3, after_count: 3),
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
