# ======================================================
# Decorator Design Pattern Example in Ruby
# ======================================================
# Problem:
#   - We want to build different pizzas with flexible toppings.
#   - Without Decorator, we'd end up creating many subclasses:
#     (CheesePizza, CheeseOlivePizza, CheeseOlivePepperPizza...)
#
# Solution:
#   - Use the Decorator Pattern to "wrap" pizzas with toppings.
# ======================================================

# -----------------------------
# Component Interface
# -----------------------------
# Every pizza (base or decorated) must implement `description`
# and `cost`.
class Pizza
  def description
    raise NotImplementedError, "Subclasses must define description"
  end

  def cost
    raise NotImplementedError, "Subclasses must define cost"
  end
end

# -----------------------------
# Concrete Component (Base Pizza)
# -----------------------------
class Margherita < Pizza
  def description
    "Margherita Pizza"
  end

  def cost
    5.0
  end
end

class Farmhouse < Pizza
  def description
    "Farmhouse Pizza"
  end

  def cost
    7.0
  end
end

# -----------------------------
# Base Decorator
# -----------------------------
# Decorators also behave like Pizzas but wrap another Pizza.
class ToppingDecorator < Pizza
  def initialize(pizza)
    @pizza = pizza
  end
end

# -----------------------------
# Concrete Decorators (Toppings)
# -----------------------------
class Cheese < ToppingDecorator
  def description
    @pizza.description + ", Extra Cheese"
  end

  def cost
    @pizza.cost + 1.5
  end
end

class Olives < ToppingDecorator
  def description
    @pizza.description + ", Olives"
  end

  def cost
    @pizza.cost + 1.0
  end
end

class Jalapenos < ToppingDecorator
  def description
    @pizza.description + ", Jalapenos"
  end

  def cost
    @pizza.cost + 1.2
  end
end

# -----------------------------
# Client Code (Demo)
# -----------------------------
# Start with a base pizza
pizza1 = Margherita.new
puts "#{pizza1.description} => $#{pizza1.cost}"

# Add cheese
pizza2 = Cheese.new(pizza1)
puts "#{pizza2.description} => $#{pizza2.cost}"

# Add olives and jalapenos on top of cheese
pizza3 = Jalapenos.new(Olives.new(pizza2))
puts "#{pizza3.description} => $#{pizza3.cost}"

# Start with a Farmhouse pizza and add toppings
pizza4 = Cheese.new(Olives.new(Farmhouse.new))
puts "#{pizza4.description} => $#{pizza4.cost}"

# ======================================================
# OUTPUT:
#
# Margherita Pizza => $5.0
# Margherita Pizza, Extra Cheese => $6.5
# Margherita Pizza, Extra Cheese, Olives, Jalapenos => $8.7
# Farmhouse Pizza, Olives, Extra Cheese => $9.5
# ======================================================