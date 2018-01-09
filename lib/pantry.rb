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

  def restock(ingredient, quantity)
    if @stock[ingredient] == nil
      @stock[ingredient] = quantity
    else
      @stock[ingredient] += quantity
    end
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each_pair do |key, value|
      if @shopping_list.has_key?(key)
        @shopping_list[key] += value
      else
        @shopping_list[key] = value
      end
    end
  end

  def print_shopping_list
    list = ""
    @shopping_list.each_pair do |key, value|
      line_item = "* #{key}: #{value}\n"
      list += line_item
    end
    list.chomp
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

end
