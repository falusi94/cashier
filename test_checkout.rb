# frozen_string_literal: true

require 'test/unit'
require './checkout'

class TestCheckout < Test::Unit::TestCase
  def setup
    @checkout = Checkout.new
  end

  def test_scan_item
    item = { product_code: 'gr1', name: 'Green tea', price: '3.11' }
    items = @checkout.scan(item)
    assert_equal items.count, 1
  end
end
