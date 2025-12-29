# =========================================
# Bridge Design Pattern - Ruby
# =========================================

# --------------------------------------------------
# PROBLEM:
#
# Suppose we want to model Shapes and Colors.
# Without the Bridge pattern, we might create classes like:
#
#   RedCircle, BlueCircle, RedSquare, BlueSquare
#
# As we add more shapes or colors, the number of classes
# grows exponentially (class explosion).
#
# This leads to:
# - Tight coupling between shape and color
# - Poor scalability
# - Difficult maintenance
#
# SOLUTION:
#
# The Bridge pattern separates:
# - Abstraction (Shape)
# - Implementation (Color)
#
# Both can vary independently and are connected
# using composition instead of inheritance.
# --------------------------------------------------


# -----------------------------------------
# IMPLEMENTOR INTERFACE
# -----------------------------------------
class Color
  def apply_color
    raise NotImplementedError
  end
end


# -----------------------------------------
# CONCRETE IMPLEMENTORS
# -----------------------------------------
class RedColor < Color
  def apply_color
    "Red"
  end
end

class BlueColor < Color
  def apply_color
    "Blue"
  end
end


# -----------------------------------------
# ABSTRACTION
# -----------------------------------------
class Shape
  def initialize(color)
    # Bridge: Shape is composed with Color
    @color = color
  end

  def draw
    raise NotImplementedError
  end
end


# -----------------------------------------
# REFINED ABSTRACTIONS
# -----------------------------------------
class Circle < Shape
  def draw
    puts "Drawing a #{@color.apply_color} Circle"
  end
end

class Square < Shape
  def draw
    puts "Drawing a #{@color.apply_color} Square"
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------
# Client can combine any shape with any color
# without creating new subclasses.

red = RedColor.new
blue = BlueColor.new

circle = Circle.new(red)
square = Square.new(blue)

circle.draw
square.draw
