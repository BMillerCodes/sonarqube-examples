require_relative 'main'
require_relative 'helpers'
require_relative 'models/user'
require_relative 'models/order'

class TestMain < Test::Unit::TestCase
  def test_calculator_add
    assert_equal(8, Calculator.add(3, 5))
    assert_equal(0, Calculator.add(-5, 5))
    assert_equal(100, Calculator.add(50, 50))
  end

  def test_calculator_divide
    assert_in_delta(2.5, Calculator.divide(5, 2), 0.001)
    assert_in_delta(10.0, Calculator.divide(100, 10), 0.001)
  end

  def test_calculator_divide_by_zero
    assert_raise(ArgumentError) { Calculator.divide(10, 0) }
  end

  def test_helper_multiply
    assert_equal(6, Helper.multiply(2, 3))
    assert_equal(0, Helper.multiply(0, 100))
    assert_equal(50, Helper.multiply(10, 5))
  end

  def test_helper_valid?
    assert_equal(true, Helper.valid?(50))
    assert_equal(true, Helper.valid?(0))
    assert_equal(true, Helper.valid?(100))
    assert_equal(false, Helper.valid?(-1))
    assert_equal(false, Helper.valid?(101))
  end

  def test_helper_format
    assert_equal('[INFO] Test message', Helper.format('Test message'))
    assert_equal('[INFO] Hello', Helper.format('Hello'))
  end

  def test_user_model
    user = User.new('Test User', 'test@example.com')
    assert_equal('Test User', user.name)
    assert_equal('test@example.com', user.email)
    assert_equal(true, user.active)
  end

  def test_order_model
    user = User.new('John', 'john@example.com')
    order = Order.new(user)
    assert_equal('pending', order.status)
    order.add_item('Widget', 2, 10.0)
    assert_equal(20.0, order.total)
  end
end