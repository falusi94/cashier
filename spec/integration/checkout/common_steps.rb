# frozen_string_literal: true

steps_for :checkout do
  attr_reader :green_tea, :strawberries, :coffee, :checkout

  step 'a setup with basic items and discounts' do
    @green_tea    = Item.parse(product_number: 'gr1', name: 'Green tea', price: 3.11)
    @strawberries = Item.parse(product_number: 'sr1', name: 'Strawberries', price: 5)
    @coffee       = Item.parse(product_number: 'cf1', name: 'Coffee', price: 11.23)
    discounts = [
      Discount.new(@green_tea, 'Buy-one-get-one-free green tea',
                   :buy_n_get_one_free, after: 2),
      Discount.new(@strawberries, 'Price discount after three strawberries',
                   :price_discount_after_n, price_discount: 0.5, after: 3),
      Discount.new(@coffee, 'Price drop after three coffees',
                   :price_drop_after_n, price_drop: 1.0 / 3, after: 3)
    ]
    @checkout = Checkout.new(discounts)
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
