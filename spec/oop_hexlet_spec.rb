require 'spec_helper'

RSpec.describe OopHexlet do
  describe '.search_geolocation' do
    before do
      stub_request(:get, 'http://ip-api.com/json/172.217.20.174').to_return(
        status: 200,
        body: <<-BODY
          {"as":"AS15169 Google LLC","city":"Warsaw","country":"Poland",
          "countryCode":"PL","isp":"Google","lat":52.2297,"lon":21.0122,
          "org":"Google","query":"172.217.20.174","region":"MZ",
          "regionName":"Masovian Voivodeship","status":"success",
          "timezone":"Europe/Warsaw","zip":"1223"}
        BODY
      )
    end

    context 'succes response' do
      subject(:geolocation) { OopHexlet.search_geolocation('172.217.20.174') }

      it { expect(geolocation.city).to eq('Warsaw') }
      it { expect(geolocation.country).to eq('Poland') }
      it { expect(geolocation.zip).to eq('1223') }
      it { expect(geolocation.lat).to eq(52.2297) }
      it { expect(geolocation.lon).to eq(21.0122) }
      it { expect(geolocation.org).to eq('Google') }
      it { expect(geolocation.status).to eq('success') }
    end
  end
end
