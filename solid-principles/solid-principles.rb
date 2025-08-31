# Single Responsibility Principle
# A class should have only one reason to change, Each class should handle only one job.

# Bad Example
class Report
  def initialize(text)
    @text = text
  end

  # Generates the report
  def generate
    "Report: #{@text}"
  end

  # Saves the report to a file (extra responsibility)
  def save_to_file
    File.open("report.txt", "w") { |f| f.write(generate) }
  end
end


# Good Example
class Report
  def initialize(text)
    @text = text
  end

  def generate
    "Report: #{@text}"
  end
end

class ReportSaver
  def save(report)
    File.open("report.txt", "w") { |f| f.write(report.generate) }
  end
end

report = Report.new("SOLID in Ruby")
saver = ReportSaver.new
saver.save(report)
