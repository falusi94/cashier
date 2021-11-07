# frozen_string_literal: true

module Pricing
  class PriceDiscountAfterN < BasePricingRule
    def initialize(name, item, after_count:, amount_of_discount:)
      super(name, item)

      @after_count        = after_count
      @amount_of_discount = amount_of_discount
    end

    def apply(items, total)
      item_count = items.count(item)
      return total if item_count < after_count

      total - item_count * amount_of_discount
    end

    private

    attr_reader :after_count, :amount_of_discount
  end
end
