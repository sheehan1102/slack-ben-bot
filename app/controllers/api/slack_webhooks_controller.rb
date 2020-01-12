module Api
  class SlackWebhooksController < ApiController
    include ApplicationHelper

    def create
      @text = params[:event][:text].downcase
      if should_get_weather?
        @forecast = DarkSkyService.get_forecast(@time)
        SlackBotService.post_message(message)
      elsif @text.include? 'quote'
        SlackBotService.post_message(weather_quotes.sample)
      end
      render json: {}, status: :ok
      # render plain: params[:challenge]
    end

    private

      def should_get_weather?
        @context = {}
        if @text.include? 'weather now'
          @context[:time] = 'now'
          true
        elsif @text.include? 'weather tomorrow'
          @time = 1.day.from_now
          @context[:time] = 'tomorrow'
          true
        elsif @text.include? 'recommendation'
          @context[:type] = 'recommendation'
          true
        else
          false
        end
      end

      def message
        opts = { forecast: @forecast, context: @context }
        FormWeatherResponse.call(opts)
      end

  end
end