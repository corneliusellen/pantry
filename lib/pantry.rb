class Pantry

  attr_reader :stock,
              :shopping_list

  def initialize
    @stock = {}
    @shopping_list = {}
  end

  def stock_check(ingredient)
    if @stock[ingredient] == nil
      0
    else
      @stock[ingredient]
    end
  end

  def restock(ingredient, quantity)
    if @stock[ingredient] == nil
      @stock[ingredient] = quantity
    else
      @stock[ingredient] += quantity
    end
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each_pair do |key, value|
      @shopping_list[key] = value
    end
  end

end
