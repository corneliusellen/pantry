class Pantry

  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(ingredient)
    @stock[ingredient]
    if @stock[ingredient] == nil
      return 0
    end
  end

  def restock(ingredient, quantity)
    require 'pry'; binding.pry
    @stock[ingredient] += quantity
  end

end
