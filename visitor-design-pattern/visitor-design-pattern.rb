# =========================================
# Visitor Design Pattern - Ruby
# =========================================

# --------------------------------------------------
# PROBLEM:
#
# Consider a system with a complex object structure
# (e.g., shapes, files, nodes).
#
# If we want to add new operations on these objects:
# - We must modify every class in the structure
# - This violates the Open/Closed Principle
# - The code becomes harder to maintain
#
# SOLUTION:
#
# The Visitor pattern:
# - Separates algorithms from the objects they operate on
# - Allows adding new operations without changing
#   existing object classes
# - Uses double dispatch to choose the correct operation
# --------------------------------------------------


# -----------------------------------------
# VISITOR INTERFACE
# -----------------------------------------
class ShapeVisitor
  def visit_circle(circle)
    raise NotImplementedError
  end

  def visit_rectangle(rectangle)
    raise NotImplementedError
  end
end


# -----------------------------------------
# ELEMENT INTERFACE
# -----------------------------------------
class Shape
  def accept(visitor)
    raise NotImplementedError
  end
end


# -----------------------------------------
# CONCRETE ELEMENTS
# -----------------------------------------
class Circle < Shape
  attr_reader :radius

  def initialize(radius)
    @radius = radius
  end

  def accept(visitor)
    visitor.visit_circle(self)
  end
end

class Rectangle < Shape
  attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
  end

  def accept(visitor)
    visitor.visit_rectangle(self)
  end
end


# -----------------------------------------
# CONCRETE VISITOR
# -----------------------------------------
class AreaCalculator < ShapeVisitor
  def visit_circle(circle)
    area = Math::PI * circle.radius * circle.radius
    puts "Circle area: #{area.round(2)}"
  end

  def visit_rectangle(rectangle)
    area = rectangle.width * rectangle.height
    puts "Rectangle area: #{area}"
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------
# New operations can be added by creating
# new visitors without modifying Shape classes.

shapes = [
  Circle.new(5),
  Rectangle.new(4, 6)
]

visitor = AreaCalculator.new

shapes.each do |shape|
  shape.accept(visitor)
end
