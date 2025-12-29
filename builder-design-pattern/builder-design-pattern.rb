# its creation design pattern when there is lots of optional fields 
# for example student model is there but it has a lots of optional fields phone number, address, etc...

# Problem It Solves
# Without Builder Pattern:
# Constructors become large and confusing
# Many optional parameters
# Hard to read and maintain code
# Car.new(engine, wheels, gps, sunroof, airbags, color)

# =========================================
# Builder Design Pattern - Ruby
# Example: Computer Builder
# =========================================

# -----------------------------------------
# PRODUCT
# -----------------------------------------
class Computer
  attr_accessor :cpu, :ram, :storage, :gpu

  def specs
    puts "CPU: #{@cpu}"
    puts "RAM: #{@ram}"
    puts "Storage: #{@storage}"
    puts "GPU: #{@gpu}"
  end
end


# -----------------------------------------
# BUILDER INTERFACE
# -----------------------------------------
class ComputerBuilder
  def build_cpu
    raise NotImplementedError
  end

  def build_ram
    raise NotImplementedError
  end

  def build_storage
    raise NotImplementedError
  end

  def build_gpu
    raise NotImplementedError
  end

  def get_computer
    raise NotImplementedError
  end
end


# -----------------------------------------
# CONCRETE BUILDER
# -----------------------------------------
class GamingComputerBuilder < ComputerBuilder
  def initialize
    @computer = Computer.new
  end

  def build_cpu
    @computer.cpu = "Intel i9"
  end

  def build_ram
    @computer.ram = "32GB"
  end

  def build_storage
    @computer.storage = "2TB SSD"
  end

  def build_gpu
    @computer.gpu = "NVIDIA RTX 4090"
  end

  def get_computer
    @computer
  end
end


# -----------------------------------------
# DIRECTOR (Optional)
# -----------------------------------------
class ComputerDirector
  def initialize(builder)
    @builder = builder
  end

  def build_computer
    @builder.build_cpu
    @builder.build_ram
    @builder.build_storage
    @builder.build_gpu
  end
end


# -----------------------------------------
# CLIENT CODE
# -----------------------------------------
builder = GamingComputerBuilder.new
director = ComputerDirector.new(builder)

director.build_computer
computer = builder.get_computer

computer.specs
