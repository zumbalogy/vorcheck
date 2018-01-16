require 'order_summary'
require 'test/unit'

class TestOrderSummary < Test::Unit::TestCase
  def test_new
    assert_not_nil OrderSummary.new([])
  end

  def test_total
    item1 = Product.new('Cat food', 3.35)
    item2 = Product.new('Bun', 0.50)

    summary = OrderSummary.new([item1, item2])
    assert_equal 3.85, summary.total
  end
end
