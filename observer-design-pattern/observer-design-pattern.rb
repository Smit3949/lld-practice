# ======================================================
# Observer Design Pattern Example in Ruby
# ======================================================
# The Observer pattern defines a one-to-many relationship
# between objects. When the Subject changes state, it
# notifies all Observers automatically.
#
# Example: Weather Station (Subject) notifies different
# display devices (Observers) whenever temperature changes.
# ======================================================

# -----------------------------
# Observer Interface (Contract)
# -----------------------------
# Every Observer must implement the `update` method.
# This ensures they know how to receive updates from the Subject.
module Observer
  def update(data)
    raise NotImplementedError, "Observers must implement update method"
  end
end

# -----------------------------
# Subject (WeatherStation)
# -----------------------------
# The WeatherStation is the Subject that maintains a list
# of observers and notifies them whenever the temperature changes.
class WeatherStation
  def initialize
    @observers = []   # List of subscribers
    @temperature = nil
  end

  # Register an observer
  def add_observer(observer)
    @observers << observer
  end

  # Remove an observer
  def remove_observer(observer)
    @observers.delete(observer)
  end

  # Notify all observers of state change
  def notify_observers
    @observers.each { |observer| observer.update(@temperature) }
  end

  # Set a new temperature and notify observers
  def set_temperature(temp)
    puts "\n🌡️ WeatherStation: New temperature recorded: #{temp}°C"
    @temperature = temp
    notify_observers
  end
end

# -----------------------------
# Concrete Observers
# -----------------------------
# Each observer implements the Observer interface and defines
# how it reacts when the Subject notifies it.

class PhoneDisplay
  include Observer

  def update(temperature)
    puts "📱 Phone Display: Current temperature is #{temperature}°C"
  end
end

class WindowDisplay
  include Observer

  def update(temperature)
    puts "🪟 Window Display: Current temperature is #{temperature}°C"
  end
end

class CarDisplay
  include Observer

  def update(temperature)
    puts "🚗 Car Display: Current temperature is #{temperature}°C"
  end
end

# -----------------------------
# Client Code (Demo)
# -----------------------------
# 1. Create the Subject (WeatherStation)
station = WeatherStation.new

# 2. Create Observers
phone_display   = PhoneDisplay.new
window_display  = WindowDisplay.new
car_display     = CarDisplay.new

# 3. Attach Observers to Subject
station.add_observer(phone_display)
station.add_observer(window_display)
station.add_observer(car_display)

# 4. Change state -> all observers are notified
station.set_temperature(25)
station.set_temperature(30)

# 5. Remove one observer (WindowDisplay unsubscribes)
station.remove_observer(window_display)

# 6. Change state again -> only remaining observers are updated
station.set_temperature(28)

# ======================================================
# OUTPUT:
#
# 🌡️ WeatherStation: New temperature recorded: 25°C
# 📱 Phone Display: Current temperature is 25°C
# 🪟 Window Display: Current temperature is 25°C
# 🚗 Car Display: Current temperature is 25°C
#
# 🌡️ WeatherStation: New temperature recorded: 30°C
# 📱 Phone Display: Current temperature is 30°C
# 🪟 Window Display: Current temperature is 30°C
# 🚗 Car Display: Current temperature is 30°C
#
# 🌡️ WeatherStation: New temperature recorded: 28°C
# 📱 Phone Display: Current temperature is 28°C
# 🚗 Car Display: Current temperature is 28°C
# ======================================================