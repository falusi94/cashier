# frozen_string_literal: true

class Checkout
  attr_accessor :discounts

  def initialize
    @items = []
    @discounts = []
  end

  def scan(item)
    @items.push item
  end

  def total
    sum = @items.map(&:price).inject(:+) || 0
    @discounts&.each { |discount| sum = discount.apply(@items, sum) }
    sum
  end

  def add_discount(discount)
    @discounts.push discount
  end
end
