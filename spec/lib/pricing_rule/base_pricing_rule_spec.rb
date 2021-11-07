# frozen_string_literal: true

RSpec.describe Pricing::BasePricingRule do
  describe '#apply' do
    it 'raises NotImplementedError' do
      discount = described_class.new('name', nil)

      expect { discount.apply([], 0) }.to raise_error(NotImplementedError)
    end
  end
end
