# it bridge the gap between existing interface and expected interface 
# The Adapter Design Pattern is a structural design pattern that allows two incompatible interfaces to work together.

# =========================================
# Adapter Design Pattern - Ruby
# Example: Payment Gateway
# =========================================

# --------------------------------------------------
# PROBLEM:
#
# An application expects an object with a specific
# interface, but an existing or third-party class
# provides a different (incompatible) interface.
#
# Without Adapter:
# - Client code must be modified to handle differences
# - Tight coupling to third-party code
# - Hard to replace or extend integrations
#
# SOLUTION:
#
# The Adapter pattern:
# - Converts one interface into another expected by the client
# - Allows reuse of existing / third-party code
# - Keeps client code unchanged
# --------------------------------------------------


# -----------------------------------------
# TARGET INTERFACE
# -----------------------------------------
class PaymentGateway
  def process_payment(amount)
    raise NotImplementedError
  end
end


# -----------------------------------------
# ADAPTEE (Third-party / Incompatible class)
# -----------------------------------------
class ThirdPartyPaymentService
  def make_payment(value)
    puts "Third-party service processing payment of $#{value}"
  end
end


# -----------------------------------------
# ADAPTER
# -----------------------------------------
class PaymentAdapter < PaymentGateway
  def initialize(third_party_service)
    @third_party_service = third_party_service
  end

  def process_payment(amount)
    # Translate method call
    @third_party_service.make_payment(amount)
  end
end


# -----------------------------------------
# CLIENT
# -----------------------------------------
class Checkout
  def initialize(payment_gateway)
    @payment_gateway = payment_gateway
  end

  def pay(amount)
    @payment_gateway.process_payment(amount)
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------
third_party_service = ThirdPartyPaymentService.new
payment_adapter = PaymentAdapter.new(third_party_service)

checkout = Checkout.new(payment_adapter)
checkout.pay(100)
