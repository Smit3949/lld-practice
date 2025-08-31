# Subclasses should be replaceable with their parent classes without breaking the program.

# Bad Example
class Bird
  def fly
    "I can fly!"
  end
end

class Penguin < Bird
  def fly
    raise "Penguins can't fly!"
  end
end


# Good Example
class Bird
end

class FlyingBird < Bird
  def fly
    "I can fly!"
  end
end

class Penguin < Bird
  def swim
    "I can swim!"
  end
end

def make_it_fly(bird)
  puts bird.fly if bird.is_a?(FlyingBird)
end

make_it_fly(FlyingBird.new) # ✅ works
make_it_fly(Penguin.new)    # ✅ doesn't break