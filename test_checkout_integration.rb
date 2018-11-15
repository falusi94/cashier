# frozen_string_literal: true

require 'test/unit'
require './checkout'
require './item'
require './discount'

class TestCheckoutIntegration < Test::Unit::TestCase
  def setup
    @checkout = Checkout.new
    @green_tea = Item.new(product_code: 'gr1', name: 'Green tea', price: 3.11)
    @strawberries = Item.new(product_code: 'sr1', name: 'Strawberries', price: 5)
    @coffee = Item.new(product_code: 'cf1', name: 'Coffee', price: 11.23)
    @checkout.discounts = [
      Discount.new(@green_tea, 'Buy-one-get-one-free green tea', :buy_one_get_one_free),
      Discount.new(@strawberries, 'Price discount after three strawberries',
                   :price_discount_after_n, price_discount: 0.5, after: 3),
      Discount.new(@coffee, 'Price drop after three coffees',
                   :price_drop_after_n, price_drop: 1.0 / 3, after: 3)
    ]
  end

  def test_case_1
    @checkout.scan(@green_tea)
    @checkout.scan(@strawberries)
    @checkout.scan(@green_tea)
    @checkout.scan(@green_tea)
    @checkout.scan(@coffee)
    assert_equal 22.45, @checkout.total
  end
end
