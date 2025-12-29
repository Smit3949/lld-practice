# =========================================
# Iterator Design Pattern - Ruby
# =========================================

# --------------------------------------------------
# PROBLEM:
#
# Collections (arrays, lists, trees, etc.) store data
# internally in different ways.
#
# If client code accesses elements directly:
# - Client becomes tightly coupled to the collection’s
#   internal structure
# - Changing the collection implementation breaks clients
# - Traversal logic gets duplicated across the codebase
#
# SOLUTION:
#
# The Iterator pattern:
# - Provides a standard way to traverse a collection
# - Hides the internal representation of the collection
# - Allows multiple traversal strategies
# --------------------------------------------------


# -----------------------------------------
# ITERATOR INTERFACE
# -----------------------------------------
class Iterator
  def has_next?
    raise NotImplementedError
  end

  def next
    raise NotImplementedError
  end
end


# -----------------------------------------
# CONCRETE ITERATOR
# -----------------------------------------
class NameIterator < Iterator
  def initialize(collection)
    @collection = collection
    @index = 0
  end

  def has_next?
    @index < @collection.length
  end

  def next
    value = @collection[@index]
    @index += 1
    value
  end
end


# -----------------------------------------
# AGGREGATE (COLLECTION)
# -----------------------------------------
class NameCollection
  def initialize
    @names = []
  end

  def add(name)
    @names << name
  end

  def iterator
    NameIterator.new(@names)
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------
collection = NameCollection.new
collection.add("Alice")
collection.add("Bob")
collection.add("Charlie")

iterator = collection.iterator

while iterator.has_next?
  puts iterator.next
end
