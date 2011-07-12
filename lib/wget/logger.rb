module Wget
  class Logger
    def initialize(file)
      @file = open(file, "w")
    end

    def log(line)
      @file.puts line
    end
  end
end
