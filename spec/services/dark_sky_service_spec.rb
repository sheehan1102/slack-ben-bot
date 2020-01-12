require 'rails_helper'

RSpec.describe DarkSkyService do

  describe "::get_forecast" do
    context "when time is current" do
      before do
        stub_request(:get, "https://api.darksky.net/forecast/87f143c8d2ce52a5d288b8c3df59eee1/43.64888,-72.319588,*")
          .with(
             headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent'=>'Ruby'
              }).to_return(
                body: dark_sky_weather_response
              )
      end

      it "returns current weather" do
        expect(DarkSkyService.get_forecast(Time.current)).to eq nil
      end
    end

    context "when time is tomorrow" do

    end
  end
end