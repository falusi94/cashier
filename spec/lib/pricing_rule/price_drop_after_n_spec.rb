# frozen_string_literal: true

RSpec.describe Pricing::PriceDropAfterN do
  let(:item) { build(:item, price: 2) }
  let(:discount) do
    described_class.new('Name', item, after_count: 2, discount_multiplier: 0.2)
  end

  context 'when the count of item is less than the count determined in the discount' do
    it 'returns the total' do
      total = 5
      items = [item]

      total_after_discount = discount.apply(items, total)

      expect(total_after_discount).to eq(total)
    end
  end

  context 'when the count of item is enough to satisfy the discount' do
    it 'returns a reduced total' do
      total = 5
      items = [item] * 3

      total_after_discount = discount.apply(items, total)

      expect(total_after_discount).to eq(total - 3 * item.price * 0.2)
    end
  end
end
