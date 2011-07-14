module Wget
  class Logger
    def initialize(file)
      @file = open(file, "a")
    end

    def log(line)
      @file.puts line
    end
  end
end
