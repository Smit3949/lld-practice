# Clients should not be forced to depend on methods they do not use.
# In Ruby, we don’t have formal interfaces, but we can follow this by designing smaller, focused modules.


# Bad Example
module Machine
  def print; end
  def scan; end
  def fax; end
end

class OldPrinter
  include Machine

  def print
    "Printing..."
  end

  def scan
    raise "Not supported"
  end

  def fax
    raise "Not supported"
  end
end


# Good Example
module Printer
  def print; end
end

module Scanner
  def scan; end
end

class SimplePrinter
  include Printer

  def print
    "Printing..."
  end
end

class MultiFunctionPrinter
  include Printer
  include Scanner

  def print
    "Printing..."
  end

  def scan
    "Scanning..."
  end
end