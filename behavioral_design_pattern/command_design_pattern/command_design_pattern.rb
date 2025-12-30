# =========================================
# Command Design Pattern - Ruby
# =========================================

# --------------------------------------------------
# PROBLEM:
#
# Imagine a system where a client (Invoker) needs to
# trigger actions, but:
# - The client should NOT know how the action is performed
# - The client should NOT be tightly coupled to the receiver
# - We may want to support undo/redo operations
#
# Without the Command pattern:
# - Client directly calls methods on receivers
# - Adding new commands requires modifying client code
# - Undo/redo becomes hard to implement
#
# SOLUTION:
#
# The Command pattern:
# - Encapsulates a request as an object
# - Decouples sender (Invoker) from receiver
# - Allows parameterizing objects with actions
# - Makes undo/redo possible
# --------------------------------------------------


# -----------------------------------------
# COMMAND INTERFACE
# -----------------------------------------
class Command
  def execute
    raise NotImplementedError
  end

  def undo
    raise NotImplementedError
  end
end


# -----------------------------------------
# RECEIVER
# -----------------------------------------
class Light
  def on
    puts "Light is ON"
  end

  def off
    puts "Light is OFF"
  end
end


# -----------------------------------------
# CONCRETE COMMANDS
# -----------------------------------------
class LightOnCommand < Command
  def initialize(light)
    @light = light
  end

  def execute
    @light.on
  end

  def undo
    @light.off
  end
end

class LightOffCommand < Command
  def initialize(light)
    @light = light
  end

  def execute
    @light.off
  end

  def undo
    @light.on
  end
end


# -----------------------------------------
# INVOKER
# -----------------------------------------
class RemoteControl
  def initialize
    @command_history = []
  end

  def press_button(command)
    command.execute
    @command_history << command
  end

  def press_undo
    last_command = @command_history.pop
    last_command.undo if last_command
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------
light = Light.new

light_on  = LightOnCommand.new(light)
light_off = LightOffCommand.new(light)

remote = RemoteControl.new

remote.press_button(light_on)
remote.press_button(light_off)
remote.press_undo
