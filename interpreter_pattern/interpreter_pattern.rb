# =========================================
# Interpreter Design Pattern - Ruby
# =========================================

# --------------------------------------------------
# PROBLEM:
#
# Some applications need to evaluate or interpret
# simple languages or expressions, such as:
# - Mathematical expressions
# - Search filters
# - Rule engines
# - Query languages
#
# Without a structured approach:
# - Parsing logic becomes messy
# - Logic is scattered across the code
# - Adding new grammar rules is difficult
#
# SOLUTION:
#
# The Interpreter pattern:
# - Defines a grammar using classes
# - Represents each rule as an object
# - Evaluates expressions by interpreting them
#   recursively
# --------------------------------------------------


# -----------------------------------------
# EXPRESSION INTERFACE
# -----------------------------------------
class Expression
  def interpret(context)
    raise NotImplementedError
  end
end


# -----------------------------------------
# TERMINAL EXPRESSION
# -----------------------------------------
# Represents variables or constants
class NumberExpression < Expression
  def initialize(number)
    @number = number
  end

  def interpret(context)
    @number
  end
end


# -----------------------------------------
# NON-TERMINAL EXPRESSIONS
# -----------------------------------------
class AddExpression < Expression
  def initialize(left, right)
    @left = left
    @right = right
  end

  def interpret(context)
    @left.interpret(context) + @right.interpret(context)
  end
end

class SubtractExpression < Expression
  def initialize(left, right)
    @left = left
    @right = right
  end

  def interpret(context)
    @left.interpret(context) - @right.interpret(context)
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------
# Expression: (5 + 3) - 2

expression =
  SubtractExpression.new(
    AddExpression.new(
      NumberExpression.new(5),
      NumberExpression.new(3)
    ),
    NumberExpression.new(2)
  )

result = expression.interpret(nil)

puts "Result: #{result}"
