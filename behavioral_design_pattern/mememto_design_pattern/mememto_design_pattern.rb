# =========================================
# Memento Design Pattern - Ruby
# =========================================

# --------------------------------------------------
# PROBLEM:
#
# Consider an object whose internal state changes over time
# (e.g., a text editor, game character, configuration).
#
# We want to:
# - Save the object’s state
# - Restore it later (undo / rollback)
#
# Without the Memento pattern:
# - Client may directly access and modify internal state
# - Encapsulation is broken
# - State management logic gets scattered and complex
#
# SOLUTION:
#
# The Memento pattern:
# - Captures an object’s internal state without exposing it
# - Stores the state externally (Caretaker)
# - Allows restoring the state later safely
# --------------------------------------------------


# -----------------------------------------
# MEMENTO
# -----------------------------------------
# Stores the internal state of the Originator
class EditorMemento
  attr_reader :content

  def initialize(content)
    @content = content
  end
end


# -----------------------------------------
# ORIGINATOR
# -----------------------------------------
# The object whose state we want to save/restore
class TextEditor
  def initialize
    @content = ""
  end

  def write(text)
    @content += text
  end

  def content
    @content
  end

  # Create a memento containing the current state
  def save
    EditorMemento.new(@content)
  end

  # Restore state from a memento
  def restore(memento)
    @content = memento.content
  end
end


# -----------------------------------------
# CARETAKER
# -----------------------------------------
# Manages saved states but does not inspect them
class History
  def initialize
    @mementos = []
  end

  def save(memento)
    @mementos << memento
  end

  def undo
    @mementos.pop
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------
editor = TextEditor.new
history = History.new

editor.write("Hello ")
history.save(editor.save)

editor.write("World!")
history.save(editor.save)

puts "Current content: #{editor.content}"

# Undo last change
editor.restore(history.undo)
puts "After undo: #{editor.content}"

# Undo again
editor.restore(history.undo)
puts "After second undo: #{editor.content}"
