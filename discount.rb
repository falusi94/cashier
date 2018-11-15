# frozen_string_literal: true

class Discount
  attr_reader :name, :item

  def initialize(item, name)
    @item = item
    @name = name
  end

  def apply(items, sum)
    item_count = items.count(@item)
    sum - item_count / 2 * @item.price
  end
end
