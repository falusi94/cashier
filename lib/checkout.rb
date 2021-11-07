# frozen_string_literal: true

class Checkout
  attr_reader :pricing_rules, :items

  def initialize(pricing_rules = [])
    @items         = []
    @pricing_rules = pricing_rules
  end

  def scan(item)
    @items.push(item)
  end

  def total
    total = items.map(&:price).inject(:+) || 0

    pricing_rules.inject(total) { |sum, rule| rule.apply(items, sum) }.round(2)
  end
end
