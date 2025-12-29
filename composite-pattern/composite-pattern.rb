# tree like structure
# Composite pattern allows you to compose objects into tree structures and work with them as if they were individual objects.
# Without Composite Pattern:
# Client must distinguish between single objects and groups
# Code becomes complex with condition checks
# if item.is_a?(File)
#   item.size
# else
#   item.children.each { |child| child.size }
# end



# Component
#  ├── Leaf
#  └── Composite (contains Components)



# =========================================
# Composite Design Pattern - Ruby
# Example: File System
# =========================================

# -----------------------------------------
# COMPONENT
# -----------------------------------------
class FileSystemComponent
  def size
    raise NotImplementedError
  end

  def display(indent = 0)
    raise NotImplementedError
  end
end


# -----------------------------------------
# LEAF
# -----------------------------------------
class FileItem < FileSystemComponent
  def initialize(name, size)
    @name = name
    @size = size
  end

  def size
    @size
  end

  def display(indent = 0)
    puts "#{' ' * indent}- File: #{@name} (#{@size} KB)"
  end
end


# -----------------------------------------
# COMPOSITE
# -----------------------------------------
class Folder < FileSystemComponent
  def initialize(name)
    @name = name
    @children = []
  end

  def add(component)
    @children << component
  end

  def remove(component)
    @children.delete(component)
  end

  def size
    @children.map(&:size).sum
  end

  def display(indent = 0)
    puts "#{' ' * indent}+ Folder: #{@name} (#{size} KB)"
    @children.each { |child| child.display(indent + 2) }
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------

file1 = FileItem.new("file1.txt", 10)
file2 = FileItem.new("file2.txt", 20)
file3 = FileItem.new("file3.txt", 30)

docs = Folder.new("Documents")
pics = Folder.new("Pictures")
root = Folder.new("Root")

docs.add(file1)
docs.add(file2)
pics.add(file3)

root.add(docs)
root.add(pics)

root.display