# =========================================
# Flyweight Design Pattern - Ruby
# =========================================

# --------------------------------------------------
# PROBLEM:
#
# Imagine an application that needs to display a huge number
# of similar objects (e.g., characters in a text editor,
# trees in a game, particles in a simulation).
#
# If each object stores all its data independently:
# - Memory usage becomes very high
# - Performance degrades
#
# Many of these objects share common data
# (font, color, texture, shape, etc.).
#
# SOLUTION:
#
# The Flyweight pattern reduces memory usage by:
# - Sharing common (intrinsic) state between objects
# - Storing unique (extrinsic) state externally
#
# Objects are reused instead of created repeatedly.
# --------------------------------------------------


# -----------------------------------------
# FLYWEIGHT
# -----------------------------------------
class Character
  # Intrinsic state (shared)
  def initialize(char, font)
    @char = char
    @font = font
  end

  # Extrinsic state (position) is passed in
  def display(x, y)
    puts "Character '#{@char}' with font '#{@font}' at (#{x}, #{y})"
  end
end


# -----------------------------------------
# FLYWEIGHT FACTORY
# -----------------------------------------
class CharacterFactory
  def initialize
    @characters = {}
  end

  def get_character(char, font)
    key = "#{char}_#{font}"

    # Reuse existing object if already created
    @characters[key] ||= Character.new(char, font)
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------
factory = CharacterFactory.new

# These characters share the same intrinsic state (char, font)
c1 = factory.get_character("A", "Arial")
c2 = factory.get_character("A", "Arial")
c3 = factory.get_character("B", "Arial")

# Extrinsic state (position) is different for each usage
c1.display(10, 20)
c2.display(30, 40)
c3.display(50, 60)
