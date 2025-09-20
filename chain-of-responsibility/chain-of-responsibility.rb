# ATM vanding machine
# Design logger is application
# basically you want to setof things for someone but if its not available then next assign to someone else 
# for example approvals first it will send to CEO but then he is not available then president it not available then manager like that...  


# Base Handler
class Logger
  attr_accessor :next_logger

  INFO = 1
  WARNING = 2
  ERROR = 3

  def initialize(level)
    @level = level
  end

  def set_next(next_logger)
    @next_logger = next_logger
    next_logger
  end

  def log_message(level, message)
    if @level <= level
      write(message)
    end
    @next_logger&.log_message(level, message)
  end

  def write(message)
    raise NotImplementedError, "Subclasses must implement write method"
  end
end

# Concrete Handlers
class InfoLogger < Logger
  def write(message)
    puts "INFO: #{message}"
  end
end

class WarningLogger < Logger
  def write(message)
    puts "WARNING: #{message}"
  end
end

class ErrorLogger < Logger
  def write(message)
    puts "ERROR: #{message}"
  end
end

# Client code
def get_logger_chain
  error_logger = ErrorLogger.new(Logger::ERROR)
  warning_logger = WarningLogger.new(Logger::WARNING)
  info_logger = InfoLogger.new(Logger::INFO)

  error_logger.set_next(warning_logger).set_next(info_logger)
  error_logger
end

# Usage
logger_chain = get_logger_chain

logger_chain.log_message(Logger::INFO, "This is an info message.")
logger_chain.log_message(Logger::WARNING, "This is a warning.")
logger_chain.log_message(Logger::ERROR, "This is an error!")



# another example
# Base Handler
class Approver
  attr_accessor :next_approver

  def initialize(name, limit)
    @name = name
    @limit = limit
  end

  def set_next(approver)
    @next_approver = approver
    approver
  end

  def process_request(amount)
    if amount <= @limit
      approve(amount)
    elsif @next_approver
      @next_approver.process_request(amount)
    else
      puts "Request of $#{amount} cannot be approved."
    end
  end

  def approve(amount)
    puts "#{@name} approved the purchase of $#{amount}"
  end
end

# Concrete Handlers
class Manager < Approver
  def initialize
    super("Manager", 1000)
  end
end

class Director < Approver
  def initialize
    super("Director", 5000)
  end
end

class CEO < Approver
  def initialize
    super("CEO", Float::INFINITY)  # No limit
  end
end

# Client code
def setup_approvers
  manager = Manager.new
  director = Director.new
  ceo = CEO.new

  manager.set_next(director).set_next(ceo)
  manager
end

# Usage
approver_chain = setup_approvers

approver_chain.process_request(500)   # Manager handles
approver_chain.process_request(2500)  # Director handles
approver_chain.process_request(10000) # CEO handles