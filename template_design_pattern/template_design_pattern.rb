# =========================================
# Template Method Design Pattern - Ruby
# =========================================

# --------------------------------------------------
# PROBLEM:
#
# In many systems, multiple classes follow the same
# overall algorithm but differ in certain steps.
#
# Without a structured approach:
# - Code gets duplicated across classes
# - Small changes require updates in many places
# - Algorithm structure becomes inconsistent
#
# SOLUTION:
#
# The Template Method pattern:
# - Defines the skeleton of an algorithm in a base class
# - Lets subclasses override specific steps
# - Keeps the overall algorithm structure fixed
# --------------------------------------------------


# -----------------------------------------
# ABSTRACT CLASS (TEMPLATE)
# -----------------------------------------
class DataProcessor
  # Template Method
  def process
    read_data
    process_data
    save_data
  end

  def read_data
    raise NotImplementedError
  end

  def process_data
    raise NotImplementedError
  end

  def save_data
    puts "Saving processed data"
  end
end


# -----------------------------------------
# CONCRETE IMPLEMENTATIONS
# -----------------------------------------
class CSVDataProcessor < DataProcessor
  def read_data
    puts "Reading data from CSV file"
  end

  def process_data
    puts "Processing CSV data"
  end
end

class JSONDataProcessor < DataProcessor
  def read_data
    puts "Reading data from JSON file"
  end

  def process_data
    puts "Processing JSON data"
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------
csv_processor = CSVDataProcessor.new
json_processor = JSONDataProcessor.new

csv_processor.process
puts "--------------------"
json_processor.process
