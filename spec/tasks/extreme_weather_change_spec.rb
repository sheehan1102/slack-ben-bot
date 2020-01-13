require 'rails_helper'

def modified_dark_sky_response(temp)
  dark_sky_weather_response.merge({
    "currently" => {
      "temperature" => temp
    }
  })
end

RSpec.describe 'rake extreme_weather_change', type: :task do
  before do
    @normal_temp = 50.00
    @normal_day = modified_dark_sky_response(@normal_temp)
    allow(DarkSkyService).to receive(:get_forecast).and_return(@normal_day)
    allow(SlackBotService).to receive(:post_message).and_return(true)
  end

  context "when temperature is stable" do
    before do
      allow(DarkSkyService).to receive(:get_current_forecast).and_return(@normal_day)
    end

    it "does not call SlackBotService" do
      expect(SlackBotService).not_to receive(:post_message)
      task.execute
    end
  end

  context "when temperature goes way up" do
    before do
      temp = @normal_temp + Figaro.env.temperature_change_minimum.to_i
      warmer_response = modified_dark_sky_response(temp)
      allow(DarkSkyService).to receive(
        :get_current_forecast
      ).and_return(warmer_response)
    end

    it "calls SlackBotService" do
      expect(SlackBotService).to receive(:post_message).with(
        "<!channel> Look out! It's going to be so much warmer than yesterday!"
      )
      task.execute
    end
  end

  context "when temperature goes way down" do
    before do
      temp = @normal_temp - Figaro.env.temperature_change_minimum.to_i
      colder_response = modified_dark_sky_response(temp)
      allow(DarkSkyService).to receive(
        :get_current_forecast
      ).and_return(colder_response)
    end

    it "calls SlackBotService" do
      expect(SlackBotService).to receive(:post_message).with(
        "<!channel> Look out! It's going to be so much colder than yesterday!"
      )
      task.execute
    end
  end
end