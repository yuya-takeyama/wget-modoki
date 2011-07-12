module Wget
  class Console
    def initialize(option)
      @option = option
    end

    def run
      res = Request.new(@option).call
      STDOUT.puts(res.body)
      open(@option.filename, 'w') do |file|
        file.puts res.body
      end
    end

    def logger=(logger)
      @logger = logger
    end
  end
end
