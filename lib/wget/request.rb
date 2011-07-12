require 'uri'
require 'net/http'
require 'open-uri'

module Wget
  class Request
    def initialize(option)
      @option = option
      if @option.has_url?
        @http = ::URI.parse(@option.url)
        @request = ::Net::HTTP
      else
        raise "No URL is specified."
      end
      params = {}
      params[:http_basic_authentication] = [@option.user, @option.password] if @option.has_user? and @option.has_password?
      params["User-Agent"] = @option.user_agent if @option.has_user_agent?
      @response = open(@http.to_s, params)
    end

    def call
      Response.new(@response)
    end
  end
end
