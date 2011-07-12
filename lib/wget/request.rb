require 'uri'
require 'net/http'

module Wget
  class Request
    def initialize(option)
      @option = option
    end

    def fetch(url, limit = 10)
      p url
      url = URI.parse(url)
      req = Net::HTTP::Get.new(url.path)
      req.initialize_http_header("User-Agent" => @option.user_agent) if @option.has_user_agent?
      req.basic_auth(@option.user, @option.password) if @option.has_user? and @option.has_password?

      response = Net::HTTP.start(url.host, url.port) do |http|
        http.request(req)
      end

      case response
      when Net::HTTPSuccess     then response
      when Net::HTTPRedirection then fetch(response['Location'], limit - 1)
      else
        response.error!
      end
    end

    def call
      Response.new(fetch(@option.url))
    end
  end
end
