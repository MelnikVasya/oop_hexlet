require 'uri'
require 'net/http'
require 'json'

require 'oop_hexlet/version'

module OopHexlet
  URL = 'http://ip-api.com/json/'.freeze
  Geolocation = Struct.new(:city, :country, :zip, :lat, :lon, :org, :status,
                           :message)

  class << self
    def search_geolocation(ip)
      response = get_response(ip)
      parse(response)
    end

    private

    def get_response(ip)
      uri = URI.join(URL, ip)
      Net::HTTP.get_response(uri)
    end

    def parse(response)
      info = JSON.parse(response.body)
      Geolocation.new(info['city'], info['country'], info['zip'], info['lat'],
                      info['lon'], info['org'], info['status'], info['message'])
    end
  end
end
