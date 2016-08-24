module Googl

  class Shorten < Base

    include Googl::Utils

    attr_accessor :short_url, :long_url

    # Creates a new short URL, see Googl.shorten
    #
    def initialize(long_url, user_ip=nil, api_key=nil)
      shorten_url = API_URL
      modify_headers('Content-Type' => 'application/json')
      options = {"longUrl" => long_url}.to_json

      unless api_key.nil?
        shorten_url += "?key=#{api_key}"
      end

      resp = post(shorten_url, :body => options)
      if resp.code == 200
        self.short_url  = resp['id']
        self.long_url   = resp['longUrl']
      else
        raise exception(resp.parsed_response)
      end
    end

  end

end
