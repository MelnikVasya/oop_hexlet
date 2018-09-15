require 'spec_helper'

RSpec.describe OopHexlet do
  describe '.search_geolocation' do
    context 'succes response' do
      before do
        succes_response = double('succes_body')
        @http_client = double('http_client')

        allow(succes_response).to receive(:body) do
          <<-BODY
            {"as":"AS15169 Google LLC","city":"Warsaw","country":"Poland",
            "countryCode":"PL","isp":"Google","lat":52.2297,"lon":21.0122,
            "org":"Google","query":"172.217.20.174","region":"MZ",
            "regionName":"Masovian Voivodeship","status":"success",
            "timezone":"Europe/Warsaw","zip":"1223"}
          BODY
        end

        allow(@http_client).to receive(:get_response) { succes_response }
      end

      subject(:geolocation) do
        OopHexlet.search_geolocation('172.217.20.174', @http_client)
      end

      it { expect(geolocation.city).to eq('Warsaw') }
      it { expect(geolocation.country).to eq('Poland') }
      it { expect(geolocation.zip).to eq('1223') }
      it { expect(geolocation.lat).to eq(52.2297) }
      it { expect(geolocation.lon).to eq(21.0122) }
      it { expect(geolocation.org).to eq('Google') }
      it { expect(geolocation.status).to eq('success') }
      it { expect(geolocation.message).to eq(nil) }
    end

    context 'invalid query' do
      before do
        @http_client = double('http_client')
        fail_response = double('succes_body')

        allow(fail_response).to receive(:body) do
          <<-BODY
            {"message":"invalid query","query":"invalid_query","status":"fail"}
          BODY
        end

        allow(@http_client).to receive(:get_response) { fail_response }
      end

      subject(:geolocation) do
        OopHexlet.search_geolocation('invalid_query', @http_client)
      end

      it { expect(geolocation.city).to eq(nil) }
      it { expect(geolocation.country).to eq(nil) }
      it { expect(geolocation.zip).to eq(nil) }
      it { expect(geolocation.lat).to eq(nil) }
      it { expect(geolocation.lon).to eq(nil) }
      it { expect(geolocation.org).to eq(nil) }
      it { expect(geolocation.status).to eq('fail') }
      it { expect(geolocation.message).to eq('invalid query') }
    end
  end
end
