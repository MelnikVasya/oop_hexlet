require 'uri'
require 'net/http'
require 'json'

require 'oop_hexlet/version'

module OopHexlet
  URL = 'http://ip-api.com/json/'.freeze
  Geolocation = Struct.new(:as, :city, :country, :zip, :country_code, :isp,
                           :lat, :lon, :org, :region, :region_name, :status,
                           :timezone)

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
      Geolocation.new(info['as'], info['city'], info['country'], info['zip'],
                      info['countryCode'], info['isp'], info['lat'],
                      info['lon'], info['org'], info['region'],
                      info['regionName'], info['status'], info['timezone'])
    end
  end
end
