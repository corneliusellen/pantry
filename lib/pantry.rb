class Pantry

  attr_reader :stock,
              :shopping_list,
              :cookbook

  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = []
  end

  def stock_check(ingredient)
    if @stock[ingredient] == nil
      0
    else
      @stock[ingredient]
    end
  end

  def restock(ingredient, amount)
    if @stock[ingredient] == nil
      @stock[ingredient] = amount
    else
      @stock[ingredient] += amount
    end
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each_pair do |ingredient, amount|
      if @shopping_list.has_key?(ingredient)
        @shopping_list[ingredient] += amount
      else
        @shopping_list[ingredient] = amount
      end
    end
  end

  def print_shopping_list
    list = ""
    @shopping_list.each_pair do |ingredient, amount|
      line_item = "* #{ingredient}: #{amount}\n"
      list += line_item
    end
    list.chomp
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    recommended_recipes.map {|recipe| recipe.name}
  end

  def recommended_recipes
    @cookbook.find_all do |recipe|
      check_for_ingredients(recipe) == true
    end
  end

  def check_for_ingredients(recipe)
    recipe.ingredients.all? do |ingredient, amount|
      amount <= @stock[ingredient]
    end
  end

  def how_many_can_i_make
    quantities = recommended_recipes.map do |recipe|
      check_for_quanity_in_stock(recipe)
    end
    what_can_i_make.zip(quantities).to_h
  end

  def check_for_quanity_in_stock(recipe)
    available_quanities_per_ingredient = recipe.ingredients.map do |ingredient, amount|
      @stock[ingredient] / amount
    end
    available_quanities_per_ingredient.min
  end
end
