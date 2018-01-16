require 'spec_helper'
require 'order_summary'

RSpec.describe OrderSummary do
  subject { OrderSummary.new(items) }

  let(:items) {
    [ Product.new('Cat food', 3.35),
      Product.new('Bun', 0.50) ]
  }

  describe '#total' do
    it 'returns the total price of the order' do
      expect(subject.total).to eq(3.85)
    end
  end

  describe '#tax' do
    it 'returns the calculated tax' do
      expect(subject.tax).to eq(3.85 * 0.05)
    end
  end

  describe '#grand_total' do
    it 'returns the calculated tax' do
      expect(subject.grand_total).to eq(3.85 * 1.05)
    end
  end
end

RSpec.describe OrderSummary do
  subject { Product.new('Dog food', 3.00) }

  it 'has a name' do
    expect(subject.get_name).to eq('Dog food')
  end

  it 'has a price' do
    expect(subject.get_price).to eq(3.00)
  end
end
