# Classes should be open for extension but closed for modification, You should be able to add new behavior without changing existing code.

# Bad Example: as you can see this is bad example as if we want to add new type of student then we will have to modify class 
class Discount
  def initialize(type)
    @type = type
  end

  def calculate(price)
    if @type == :student
      price * 0.9
    elsif @type == :senior
      price * 0.8
    else
      price
    end
  end
end

# Good Example: you should be able to extend class 
class Discount
  def calculate(price)
    price
  end
end

class StudentDiscount < Discount
  def calculate(price)
    price * 0.9
  end
end

class SeniorDiscount < Discount
  def calculate(price)
    price * 0.8
  end
end

def print_price(discount, price)
  puts "Final price: #{discount.calculate(price)}"
end

print_price(StudentDiscount.new, 100)
print_price(SeniorDiscount.new, 100)

