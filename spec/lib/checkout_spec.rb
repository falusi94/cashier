# frozen_string_literal: true

RSpec.describe Checkout do
  let(:checkout) { described_class.new }

  describe '#scan' do
    it 'saves item' do
      item = build(:green_tea)

      checkout.scan(item)

      expect(checkout.items).to match([item])
    end
  end

  describe '#total' do
    context 'when there is no item added' do
      it 'returns 0' do
        expect(checkout.total).to eq(0)
      end
    end

    context 'when there is one item added' do
      it 'returns the price of the item' do
        item = build(:green_tea)
        checkout.scan(item)

        expect(checkout.total).to eq(item.price)
      end
    end
  end
end
