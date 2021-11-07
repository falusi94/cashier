# frozen_string_literal: true

module Pricing
  class PriceDropAfterN < BasePricingRule
    def initialize(name, item, after_count:, discount_multiplier:)
      super(name, item)

      @after_count         = after_count
      @discount_multiplier = discount_multiplier
    end

    def apply(items, total)
      item_count = items.count(item)
      return total if item_count < after_count

      total - item_count * discount_multiplier * item.price
    end

    private

    attr_reader :after_count, :discount_multiplier
  end
end
