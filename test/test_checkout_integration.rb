# frozen_string_literal: true

require 'test/unit'
require_relative '../boot'

class TestCheckoutIntegration < Test::Unit::TestCase
  def setup
    @green_tea = Item.new(product_code: 'gr1', name: 'Green tea', price: 3.11)
    @strawberries = Item.new(product_code: 'sr1', name: 'Strawberries', price: 5)
    @coffee = Item.new(product_code: 'cf1', name: 'Coffee', price: 11.23)
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

  def test_case_1
    @checkout.scan(@green_tea)
    @checkout.scan(@strawberries)
    @checkout.scan(@green_tea)
    @checkout.scan(@green_tea)
    @checkout.scan(@coffee)
    assert_equal 22.45, @checkout.total
  end

  def test_case_2
    @checkout.scan(@green_tea)
    @checkout.scan(@green_tea)
    assert_equal 3.11, @checkout.total
  end

  def test_case_3
    @checkout.scan(@strawberries)
    @checkout.scan(@strawberries)
    @checkout.scan(@green_tea)
    @checkout.scan(@strawberries)
    assert_equal 16.61, @checkout.total
  end

  def test_case_4
    @checkout.scan(@green_tea)
    @checkout.scan(@coffee)
    @checkout.scan(@strawberries)
    @checkout.scan(@coffee)
    @checkout.scan(@coffee)
    assert_equal 30.57, @checkout.total
  end
end
