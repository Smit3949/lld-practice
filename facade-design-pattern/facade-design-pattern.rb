# =========================================
# Facade Design Pattern - Ruby
# =========================================

# --------------------------------------------------
# PROBLEM (explained in comments only):
#
# Imagine a client that wants to watch a movie.
# To do so, it must interact with many subsystems:
#  - Turn on the DVD player
#  - Set up the projector
#  - Configure the sound system
#  - Dim the lights
#
# Without a Facade:
#  - The client must know about all these subsystems
#  - The client code becomes complex and tightly coupled
#  - Any change in subsystem logic affects client code
#
# The Facade pattern solves this by providing
# a simple, unified interface that hides
# the complexity of the subsystems.
# --------------------------------------------------


# -----------------------------------------
# SUBSYSTEM CLASSES
# -----------------------------------------

class DVDPlayer
  def on
    puts "DVD Player turned ON"
  end

  def play(movie)
    puts "Playing movie: #{movie}"
  end

  def off
    puts "DVD Player turned OFF"
  end
end


class Projector
  def on
    puts "Projector turned ON"
  end

  def off
    puts "Projector turned OFF"
  end
end


class SoundSystem
  def on
    puts "Sound System turned ON"
  end

  def set_volume(level)
    puts "Sound volume set to #{level}"
  end

  def off
    puts "Sound System turned OFF"
  end
end


class Lights
  def dim
    puts "Lights dimmed"
  end

  def on
    puts "Lights turned ON"
  end
end


# -----------------------------------------
# FACADE
# -----------------------------------------
class HomeTheaterFacade
  def initialize
    @dvd = DVDPlayer.new
    @projector = Projector.new
    @sound = SoundSystem.new
    @lights = Lights.new
  end

  def watch_movie(movie)
    puts "\nStarting movie night..."
    @lights.dim
    @projector.on
    @sound.on
    @sound.set_volume(10)
    @dvd.on
    @dvd.play(movie)
  end

  def end_movie
    puts "\nEnding movie night..."
    @dvd.off
    @sound.off
    @projector.off
    @lights.on
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------
home_theater = HomeTheaterFacade.new

home_theater.watch_movie("Inception")
home_theater.end_movie
