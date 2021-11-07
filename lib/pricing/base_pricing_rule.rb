# frozen_string_literal: true

module Pricing
  class BasePricingRule
    def initialize(name, item)
      @name = name
      @item = item
    end

    def apply(items, total)
      raise NotImplementedError
    end

    private

    attr_reader :name, :item
  end
end
