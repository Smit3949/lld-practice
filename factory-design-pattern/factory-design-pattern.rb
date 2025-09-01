# ======================================================
# Factory Method Design Pattern Example in Ruby
# ======================================================
# Problem:
#   - We need to create different types of pizzas.
#   - Without Factory, client code must know which class to `new`.
#
# Solution:
#   - Factory Method defines an interface for creating an object
#     but lets subclasses decide which class to instantiate.
# ======================================================

# -----------------------------
# Product Interface
# -----------------------------
class Pizza
  def prepare
    raise NotImplementedError, "Subclasses must implement prepare"
  end
end

# -----------------------------
# Concrete Products
# -----------------------------
class Margherita < Pizza
  def prepare
    "Preparing Margherita Pizza 🍕"
  end
end

class Farmhouse < Pizza
  def prepare
    "Preparing Farmhouse Pizza 🍕"
  end
end

# -----------------------------
# Factory (Creator)
# -----------------------------
class PizzaFactory
  def self.create_pizza(type)
    case type
    when :margherita
      Margherita.new
    when :farmhouse
      Farmhouse.new
    else
      raise "Unknown pizza type!"
    end
  end
end

# -----------------------------
# Client Code
# -----------------------------
pizza1 = PizzaFactory.create_pizza(:margherita)
puts pizza1.prepare

pizza2 = PizzaFactory.create_pizza(:farmhouse)
puts pizza2.prepare