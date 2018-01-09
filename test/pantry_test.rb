require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_stocks_starts_as_empty
    pantry = Pantry.new

    assert_equal Hash.new, pantry.stock
  end

  def test_stock_test_returns_ingredient_in_pantry
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_can_restock_ingredients_in_pantry
    pantry = Pantry.new
    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 20)
    assert_equal 30, pantry.stock_check("Cheese")
  end

end
