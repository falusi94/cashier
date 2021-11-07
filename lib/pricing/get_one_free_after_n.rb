# frozen_string_literal: true

module Pricing
  class GetOneFreeAfterN < BasePricingRule
    def initialize(name, item, after_count:)
      super(name, item)

      @after_count = after_count
    end

    def apply(items, total)
      item_count = items.count(item)

      total - (item_count / after_count).to_i * item.price
    end

    private

    attr_reader :after_count
  end
end
