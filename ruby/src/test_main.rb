require_relative 'main'
require 'test/unit'

class TestCalculator < Test::Unit::TestCase
  def test_add
    assert_equal(5, Calculator.add(2, 3))
  end

  def test_divide
    assert_in_delta(5.0, Calculator.divide(10, 2), 0.001)
  end

  def test_divide_by_zero
    assert_raise(ArgumentError) { Calculator.divide(1, 0) }
  end
end
