# frozen_string_literal: true

RSpec.describe Checkout do
  let(:checkout) { described_class.new }

  describe '#scan' do
    it 'saves item' do
      item  = build(:green_tea)
      items = checkout.scan(item)

      expect(items).to include(item)
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

  describe 'discounts' do
    describe 'buy-n-get-one-free' do
      it 'applies the correct discount' do
        green_tea = build(:green_tea)
        discount = Discount.new(green_tea, 'Buy-one-get-one-free green tea',
                                :buy_n_get_one_free, after: 2)
        checkout.add_discount(discount)

        2.times { checkout.scan(green_tea) }

        expect(checkout.total).to eq(green_tea.price)
      end
    end

    describe 'price discount after n' do
      it 'applies the correct discount' do
        strawberries = build(:strawberries)
        discount = Discount.new(strawberries, 'Price discount after three strawberries',
                                :price_discount_after_n, price_discount: 0.5, after: 3)
        checkout.add_discount(discount)

        3.times { checkout.scan(strawberries) }

        expect(checkout.total).to eq(strawberries.price * 3 - 1.5)
      end
    end

    describe 'price drop after n' do
      it 'applies the correct discount' do
        coffee = build(:coffee)
        discount = Discount.new(coffee, 'Price drop after three coffees',
                                :price_drop_after_n, price_drop: 1.0 / 3, after: 3)
        checkout.add_discount(discount)

        3.times { checkout.scan(coffee) }

        expect(checkout.total).to eq(coffee.price * 2)
      end
    end
  end
end
