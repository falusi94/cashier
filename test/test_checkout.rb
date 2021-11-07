# frozen_string_literal: true

require 'test/unit'
require_relative '../boot'

class TestCheckout < Test::Unit::TestCase
  def setup
    @checkout = Checkout.new
    @green_tea = Item.new(product_number: 'gr1', name: 'Green tea', price: 3.11)
    @strawberries = Item.new(product_number: 'sr1', name: 'Strawberries', price: 5)
    @coffee = Item.new(product_number: 'cf1', name: 'Coffee', price: 11.23)
  end

  def test_scan_item
    items = @checkout.scan(@green_tea)
    assert_equal items.count, 1
  end

  def test_total_count_for_empty_cart
    assert_equal @checkout.total, 0
  end

  def test_total_count
    @checkout.scan(@green_tea)
    assert_equal @checkout.total, @green_tea.price
    @checkout.scan(@strawberries)
    assert_equal @checkout.total, @green_tea.price + @strawberries.price
  end

  def test_buy_one_get_one_free_tea
    discount = Discount.new(@green_tea, 'Buy-one-get-one-free green tea',
                            :buy_n_get_one_free, after: 2)
    @checkout.add_discount(discount)
    2.times { @checkout.scan(@green_tea) }
    assert_equal @checkout.total, @green_tea.price
  end

  def test_price_discount_after_three_strawberries
    discount = Discount.new(@strawberries, 'Price discount after three strawberries',
                            :price_discount_after_n, price_discount: 0.5, after: 3)
    @checkout.add_discount(discount)
    3.times { @checkout.scan(@strawberries) }
    assert_equal @checkout.total, @strawberries.price * 3 - 1.5
  end

  def test_price_drop_after_three_strawberries
    discount = Discount.new(@coffee, 'Price drop after three coffees',
                            :price_drop_after_n, price_drop: 1.0 / 3, after: 3)
    @checkout.add_discount(discount)
    3.times { @checkout.scan(@coffee) }
    assert_equal @checkout.total, @coffee.price * 2
  end
end
