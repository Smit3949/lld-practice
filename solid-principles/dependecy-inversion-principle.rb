# Depend on abstractions, not concrete implementations.
# Bad Code 
class FileStorage
  def save(data)
    File.open("data.txt", "w") { |f| f.write(data) }
  end
end

class Report
  def initialize
    @storage = FileStorage.new
  end

  def save(data)
    @storage.save(data)
  end
end

# Good Code
class Report
  def initialize(storage)
    @storage = storage
  end

  def save(data)
    @storage.save(data)
  end
end

class FileStorage
  def save(data)
    File.open("data.txt", "w") { |f| f.write(data) }
  end
end

class DatabaseStorage
  def save(data)
    puts "Saving #{data} to database"
  end
end

report = Report.new(FileStorage.new)
report.save("Some report data")

report = Report.new(DatabaseStorage.new)
report.save("Some report data")