# ======================================================
# Abstract Factory Design Pattern Example in Ruby
# ======================================================
# Problem:
#   - Different regions (Italian / Indian) have different
#     ingredient sets for pizzas.
#   - We want to create pizzas that automatically use the
#     correct ingredient family.
#
# Solution:
#   - Use Abstract Factory to create families of related products
#     without specifying their concrete classes.
# ======================================================

# -----------------------------
# Abstract Product Interfaces
# -----------------------------
class Dough
  def type; raise NotImplementedError; end
end

class Sauce
  def flavor; raise NotImplementedError; end
end

# -----------------------------
# Concrete Products (Italian Style)
# -----------------------------
class ItalianDough < Dough
  def type; "Thin Crust Dough"; end
end

class ItalianSauce < Sauce
  def flavor; "Tomato Basil Sauce"; end
end

# -----------------------------
# Concrete Products (Indian Style)
# -----------------------------
class IndianDough < Dough
  def type; "Thick Spicy Crust Dough"; end
end

class IndianSauce < Sauce
  def flavor; "Masala Curry Sauce"; end
end

# -----------------------------
# Abstract Factory Interface
# -----------------------------
class IngredientFactory
  def create_dough; raise NotImplementedError; end
  def create_sauce; raise NotImplementedError; end
end

# -----------------------------
# Concrete Factories
# -----------------------------
class ItalianIngredientFactory < IngredientFactory
  def create_dough; ItalianDough.new; end
  def create_sauce; ItalianSauce.new; end
end

class IndianIngredientFactory < IngredientFactory
  def create_dough; IndianDough.new; end
  def create_sauce; IndianSauce.new; end
end

# -----------------------------
# Pizza Class (Uses Factory)
# -----------------------------
class Pizza
  def initialize(factory)
    @factory = factory
  end

  def prepare
    dough = @factory.create_dough
    sauce = @factory.create_sauce
    puts "Preparing Pizza with #{dough.type} and #{sauce.flavor}"
  end
end

# -----------------------------
# Client Code
# -----------------------------
puts "\n--- Italian Pizza ---"
italian_factory = ItalianIngredientFactory.new
pizza1 = Pizza.new(italian_factory)
pizza1.prepare

puts "\n--- Indian Pizza ---"
indian_factory = IndianIngredientFactory.new
pizza2 = Pizza.new(indian_factory)
pizza2.prepare