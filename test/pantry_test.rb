require './lib/pantry'
require './lib/recipe'
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

  def test_can_add_recipe_to_shopping_list
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    pantry.add_to_shopping_list(r)

    result = {"Cheese" => 20, "Flour" => 20}

    assert_equal result, pantry.shopping_list
  end

  def test_can_add__multiple_recipes_to_shopping_list
    pantry = Pantry.new
    r_1 = Recipe.new("Cheese Pizza")
    r_1.add_ingredient("Cheese", 20)
    r_1.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r_1)

    r_2 = Recipe.new("Spaghetti")
    r_2.add_ingredient("Spaghetti Noodles", 10)
    r_2.add_ingredient("Marinara Sauce", 10)
    r_2.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r_2)

    result = {"Cheese" => 25, "Flour" => 20, "Spaghetti Noodles" => 10, "Marinara Sauce" => 10}

    assert_equal result, pantry.shopping_list
  end

  def test_can_print_shoopping_list
    pantry = Pantry.new
    r_1 = Recipe.new("Cheese Pizza")
    r_1.add_ingredient("Cheese", 20)
    r_1.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r_1)

    r_2 = Recipe.new("Spaghetti")
    r_2.add_ingredient("Spaghetti Noodles", 10)
    r_2.add_ingredient("Marinara Sauce", 10)
    r_2.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r_2)

    result = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"

    assert_equal result, pantry.print_shopping_list
  end
end
