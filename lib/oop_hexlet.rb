require 'uri'
require 'net/http'
require 'ox'

require 'oop_hexlet/version'

module OopHexlet
  URL = 'http://ipgeobase.ru:7020/geo'.freeze
  IpInformation = Struct.new(:inetnum, :country, :city, :region, :district,
                             :lat, :lng)

  class << self
    def search(ip)
      response = get_response(ip)
      parse(response)
    end

    private

    def get_response(ip)
      uri = URI(URL)
      uri.query = URI.encode_www_form(ip: ip)
      Net::HTTP.get_response(uri)
    end

    def parse(response)
      body = response.body.force_encoding('windows-1251').encode('utf-8')
      info = Ox.load(body, mode: :hash_no_attrs).dig(:"ip-answer", :ip) || {}

      IpInformation.new(info[:inetnum], info[:country], info[:city],
                        info[:region], info[:district],
                        info[:lat]&.to_f, info[:lng]&.to_f)
    end
  end
end
