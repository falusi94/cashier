# frozen_string_literal: true

class Checkout
  def initialize
    @items = []
  end

  def scan(item)
    @items.push item
  end

  def total
    @items.map(&:price).inject(:+) || 0
  end
end
