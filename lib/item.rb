# frozen_string_literal: true

Item = Struct.new(:product_number, :name, :price) do
  def self.parse(product_number: nil, name: nil, price: 0)
    new(product_number, name, price)
  end
end
