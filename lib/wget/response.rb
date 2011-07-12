module Wget
  class Response
    def initialize(res)
      @response = res
    end

    def readlines
      @buf ||= @response.readlines
    end
  end
end
