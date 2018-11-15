# frozen_string_literal: true

class Discount
  attr_reader :name, :item, :type

  def initialize(item, name, type, data = {})
    @item = item
    @name = name
    @type = type
    @data = data
  end

  def apply(items, sum)
    return buy_one_get_one_free(items, sum) if type == :buy_one_get_one_free
    return price_discount_after_n(items, sum) if type == :price_discount_after_n
    return price_drop_after_n(items, sum) if type == :price_drop_after_n

    sum
  end

  private

  def buy_one_get_one_free(items, sum)
    item_count = items.count(@item)
    sum - item_count / 2 * @item.price
  end

  def price_discount_after_n(items, sum)
    item_count = items.count(@item)
    return sum if item_count < @data[:after]

    sum - item_count * @data[:price_discount]
  end

  def price_drop_after_n(items, sum)
    item_count = items.count(@item)
    return sum if item_count < @data[:after]

    sum -= item_count * @data[:price_drop] * @item.price
    sum.round 2
  end
end
