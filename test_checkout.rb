# frozen_string_literal: true

require 'test/unit'
require './checkout'

class TestCheckout < Test::Unit::TestCase
  def test_checkout_can_be_created
    Checkout.new
  end
end
