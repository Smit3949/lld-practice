# =========================================
# STRATEGY DESIGN PATTERN - RUBY EXAMPLE
# =========================================

# -----------------------------------------
# Strategy Interface
# -----------------------------------------
# This defines a common interface for all strategies.
# Each concrete strategy must implement the `pay` method.
# Strategy means you define which method to call dynamically. 
# means instead of define conceat method you pass it as argument with dynamically 
class PaymentStrategy
  def pay(amount)
    raise NotImplementedError, "Subclasses must implement the pay method"
  end
end

# -----------------------------------------
# Concrete Strategy 1: Credit Card Payment
# -----------------------------------------
class CreditCardPayment < PaymentStrategy
  def pay(amount)
    puts "Paid $#{amount} using Credit Card"
  end
end

# -----------------------------------------
# Concrete Strategy 2: PayPal Payment
# -----------------------------------------
class PaypalPayment < PaymentStrategy
  def pay(amount)
    puts "Paid $#{amount} using PayPal"
  end
end

# -----------------------------------------
# Concrete Strategy 3: Crypto Payment
# -----------------------------------------
class CryptoPayment < PaymentStrategy
  def pay(amount)
    puts "Paid $#{amount} using Cryptocurrency"
  end
end

# -----------------------------------------
# Context Class
# -----------------------------------------
# This class uses a strategy object.
# It does NOT know which payment method is used.
# The strategy can be changed at runtime.
class Checkout
  def initialize(payment_strategy)
    @payment_strategy = payment_strategy
  end

  # Allow changing strategy dynamically
  def change_strategy(payment_strategy)
    @payment_strategy = payment_strategy
  end

  def pay(amount)
    @payment_strategy.pay(amount)
  end
end

# -----------------------------------------
# Client Code
# -----------------------------------------
# The client decides which strategy to use.
# Checkout logic remains unchanged.

checkout = Checkout.new(CreditCardPayment.new)
checkout.pay(100)

checkout.change_strategy(PaypalPayment.new)
checkout.pay(200)

checkout.change_strategy(CryptoPayment.new)
checkout.pay(300)

# -----------------------------------------
# OUTPUT:
# Paid $100 using Credit Card
# Paid $200 using PayPal
# Paid $300 using Cryptocurrency
# -----------------------------------------

# -----------------------------------------
# SUMMARY:
# - Strategy Pattern defines a family of algorithms
# - Each algorithm is encapsulated in its own class
# - Behavior can be changed at runtime
# - Eliminates large if/else or case statements
# -----------------------------------------