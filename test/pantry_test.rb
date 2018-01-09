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

  def test_can_add_multiple_recipes_to_shopping_list
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

  def test_can_add_recipes_to_cookbook
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    value = pantry.cookbook.all? do |recipe|
      recipe.class == Recipe
    end

    assert value
  end

  def test_pantry_can_recommend_recipes_and_quantities_based_on_pantry_stock
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 120)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    assert_equal ["Pickles", "Peanuts"], pantry.what_can_i_make

    result = {"Pickles" => 4, "Peanuts" => 2}
    assert_equal result, pantry.how_many_can_i_make
  end
end
