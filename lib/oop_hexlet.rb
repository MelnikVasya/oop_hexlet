require 'uri'
require 'net/http'
require 'json'

require 'oop_hexlet/version'

module OopHexlet
  URL = 'http://ip-api.com/json/'
  Geolocation = Struct.new(:city, :country, :zip, :lat, :lon, :org, :status,
                           :message)

  class << self
    def search_geolocation(ip, http_client = Net::HTTP)
      response = get_response(ip, http_client)
      parse(response)
    end

    private

    def get_response(ip, http_client)
      uri = URI.join(URL, ip)
      http_client.get_response(uri)
    end

    def parse(response)
      info = JSON.parse(response.body)
      Geolocation.new(info['city'], info['country'], info['zip'], info['lat'],
                      info['lon'], info['org'], info['status'], info['message'])
    end
  end
end
