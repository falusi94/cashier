# frozen_string_literal: true

require 'test/unit'
require './checkout'

class TestCheckout < Test::Unit::TestCase
  def setup
    @checkout = Checkout.new
    @green_tea = { product_code: 'gr1', name: 'Green tea', price: 3.11 }
    @strawberries = { product_code: 'sr1', name: 'Strawberries', price: 5 }
    @coffee = { product_code: 'cf1', name: 'Coffee', price: 11.23 }
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
    assert_equal @checkout.total, @green_tea[:price]
    @checkout.scan(@strawberries)
    assert_equal @checkout.total, @green_tea[:price] + @strawberries[:price]
  end
end
