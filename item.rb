# frozen_string_literal: true

class Item
  attr_accessor :product_number, :name, :price

  def initialize(data)
    @product_number = data[:product_number]
    @name = data[:name]
    @price = data[:price]
  end
end
