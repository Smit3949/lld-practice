# =========================================
# Mediator Design Pattern - Ruby
# =========================================

# --------------------------------------------------
# PROBLEM:
#
# In systems with many objects communicating with
# each other directly:
# - Objects become tightly coupled
# - The number of connections grows rapidly
# - Changing one object requires changes in others
#
# Example:
# - User, ChatRoom, Notification, Logger all talk
#   to each other directly
#
# This results in:
# - Hard-to-maintain code
# - Complex object relationships
#
# SOLUTION:
#
# The Mediator pattern introduces a central object
# (Mediator) that handles communication between
# components.
#
# Objects no longer communicate directly;
# they communicate through the mediator.
# --------------------------------------------------


# -----------------------------------------
# MEDIATOR INTERFACE
# -----------------------------------------
class ChatMediator
  def send_message(message, user)
    raise NotImplementedError
  end
end


# -----------------------------------------
# CONCRETE MEDIATOR
# -----------------------------------------
class ChatRoom < ChatMediator
  def initialize
    @users = []
  end

  def add_user(user)
    @users << user
  end

  def send_message(message, sender)
    @users.each do |user|
      # Do not send the message back to the sender
      user.receive(message) unless user == sender
    end
  end
end


# -----------------------------------------
# COLLEAGUE
# -----------------------------------------
class User
  def initialize(name, mediator)
    @name = name
    @mediator = mediator
  end

  def send(message)
    puts "#{@name} sends: #{message}"
    @mediator.send_message(message, self)
  end

  def receive(message)
    puts "#{@name} receives: #{message}"
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------
# Users do not talk to each other directly.
# All communication goes through the mediator.

chat_room = ChatRoom.new

alice = User.new("Alice", chat_room)
bob = User.new("Bob", chat_room)
charlie = User.new("Charlie", chat_room)

chat_room.add_user(alice)
chat_room.add_user(bob)
chat_room.add_user(charlie)

alice.send("Hello everyone!")
bob.send("Hi Alice!")
