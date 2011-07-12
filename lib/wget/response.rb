module Wget
  class Response
    def initialize(res)
      @response = res
    end

    def body
      @response.read_body
    end
  end
end
