module Wget
  class Console
    def initialize(option)
      @option = option
    end

    def run
      res = Request.new(@option).call
      STDOUT.puts(res.readlines)
      open(@option.filename, 'w') do |file|
        file.puts res.readlines
      end
    end

    def logger=(logger)
      @logger = logger
    end
  end
end
