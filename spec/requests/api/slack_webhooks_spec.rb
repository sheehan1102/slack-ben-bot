require 'rails_helper'

RSpec.describe 'Slack Webhooks endpoints', type: :request do
  describe "POST /api/slack_webhooks" do
    context "when mention has no weather-related language" do
      let(:mention) { "<@US6KWD18B> how did you like the Star Wars movie?" }

      subject do
        post "/api/slack_webhooks",
          params: slack_bot_mention.merge({ "event" => { "text" => mention } })
      end

      it "does not call Dark Sky service" do
        expect(DarkSkyService).not_to receive(:get_forecast)
        subject
      end
    end

    context "when Slack bot should respond" do
      before do
        allow(DarkSkyService).to receive(
          :get_forecast
        ).and_return(dark_sky_weather_response)
        allow(SlackBotService).to receive(
          :post_message
        ).and_return(true)
      end

      context "when mention includes 'weather now'" do
        let(:mention) { "<@US6KWD18B> weather now" }

        subject do
          post "/api/slack_webhooks",
            params: slack_bot_mention.merge({ "event" => { "text" => mention } })
        end

        it "calls Dark Sky service" do
          expect(DarkSkyService).to receive(:get_forecast)
          subject
        end

        it "calls SlackBotService" do
          expect(SlackBotService).to receive(:post_message).with(
            FormWeatherResponse.call(
              forecast: dark_sky_weather_response,
              context: { time: 'now' }
            )
          )
          subject
        end
      end

      context "when mention includes 'weather tomorrow'" do
        let(:mention) { "<@US6KWD18B> weather tomorrow" }

        subject do
          post "/api/slack_webhooks",
            params: slack_bot_mention.merge({ "event" => { "text" => mention } })
        end

        it "calls Dark Sky service" do
          expect(DarkSkyService).to receive(:get_forecast)
          subject
        end

        it "calls SlackBotService" do
          expect(SlackBotService).to receive(:post_message).with(
            FormWeatherResponse.call(
              forecast: dark_sky_weather_response,
              context: { time: 'tomorrow' }
            )
          )
          subject
        end
      end
    end
  end
end