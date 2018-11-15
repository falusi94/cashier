# frozen_string_literal: true

require 'test/unit'
require './checkout'
require './item'
require './discount'

class TestCheckout < Test::Unit::TestCase
  def setup
    @checkout = Checkout.new
    @green_tea = Item.new(product_code: 'gr1', name: 'Green tea', price: 3.11)
    @strawberries = Item.new(product_code: 'sr1', name: 'Strawberries', price: 5)
    @coffee = Item.new(product_code: 'cf1', name: 'Coffee', price: 11.23)
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
    discount = Discount.new(@green_tea, 'Buy-one-get-one-free green tea')
    @checkout.discount = discount
    2.times { @checkout.scan(@green_tea) }
    assert_equal @checkout.total, @green_tea.price
  end
end
