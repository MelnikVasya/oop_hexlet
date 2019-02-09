module OopHexlet
  class GeoIp
    URL = 'http://ip-api.com/json/'.freeze

    def initialize(http_client: Net::HTTP)
      @http_client = http_client
    end

    def load_geolocation(ip, http_client: @http_client)
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

      {
        city: info['city'],
        country: info['country'],
        zip: info['zip'],
        lat: info['lat'],
        lon: info['lon'],
        org: info['org'],
        status: info['status'],
        message: info['message']
      }
    end
  end
end
