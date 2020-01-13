module DarkSkyService
  extend self
  
  # call format: https://api.darksky.net/forecast/[key]/[latitude],[longitude],[time]
  BASE_URL = "https://api.darksky.net/forecast"
  BASE_LOCATION = {
    lat: 43.64888,
    lng: -72.319588
  }

  def get_forecast(time=nil)
    call_url = "#{BASE_URL}/#{Figaro.env.dark_sky_token}/#{coords}"
    call_url += ",#{time.to_i}" if time
    HTTParty.get(call_url)
  end

  alias_method :get_current_forecast, :get_forecast

  private

    def coords
      "#{BASE_LOCATION[:lat]},#{BASE_LOCATION[:lng]}"
    end

end