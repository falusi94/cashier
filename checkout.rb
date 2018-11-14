# frozen_string_literal: true

class Checkout
  def initialize
    @items = []
  end

  def scan(item)
    @items.push item
  end

  def total
    0
  end
end
