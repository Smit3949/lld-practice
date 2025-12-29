# Without State Pattern:
# if state == :playing
#   # do something
# elsif state == :paused
#   # do something else
# elsif state == :stopped
#   # another behavior
# end

# =========================================
# State Design Pattern - Ruby
# =========================================

# -----------------------------------------
# STATE INTERFACE
# -----------------------------------------
class PlayerState
  def play(context)
    raise NotImplementedError
  end

  def pause(context)
    raise NotImplementedError
  end

  def stop(context)
    raise NotImplementedError
  end
end


# -----------------------------------------
# CONCRETE STATES
# -----------------------------------------

class PlayingState < PlayerState
  def play(context)
    puts "Already playing."
  end

  def pause(context)
    puts "Pausing the player."
    context.state = PausedState.new
  end

  def stop(context)
    puts "Stopping the player."
    context.state = StoppedState.new
  end
end


class PausedState < PlayerState
  def play(context)
    puts "Resuming playback."
    context.state = PlayingState.new
  end

  def pause(context)
    puts "Already paused."
  end

  def stop(context)
    puts "Stopping the player from paused state."
    context.state = StoppedState.new
  end
end


class StoppedState < PlayerState
  def play(context)
    puts "Starting playback."
    context.state = PlayingState.new
  end

  def pause(context)
    puts "Cannot pause. Player is stopped."
  end

  def stop(context)
    puts "Already stopped."
  end
end


# -----------------------------------------
# CONTEXT
# -----------------------------------------
class MediaPlayer
  attr_accessor :state

  def initialize
    @state = StoppedState.new
  end

  def play
    @state.play(self)
  end

  def pause
    @state.pause(self)
  end

  def stop
    @state.stop(self)
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------
player = MediaPlayer.new

player.play    # Stopped → Playing
player.pause   # Playing → Paused
player.play    # Paused → Playing
player.stop    # Playing → Stopped
player.pause   # Invalid action