# frozen_string_literal: true

class Checkout
  attr_accessor :discount

  def initialize
    @items = []
  end

  def scan(item)
    @items.push item
  end

  def total
    sum = @items.map(&:price).inject(:+) || 0
    sum = @discount.apply(@items, sum) if @discount
    sum
  end
end
