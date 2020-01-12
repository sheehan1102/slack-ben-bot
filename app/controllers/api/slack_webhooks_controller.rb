module Api
  class SlackWebhooksController < ApiController

    def create
      if should_get_weather?
        @forecast = DarkSkyService.get_forecast(@time)
        SlackBotService.post_message(message)
      end
      render json: {}, status: :ok
      # render plain: params[:challenge]
    end

    private

      def should_get_weather?
        text = params[:event][:text].downcase
        @context = {}
        if text.include? 'weather now'
          @context[:time] = 'now'
          true
        elsif text.include? 'weather tomorrow'
          @time = 1.day.from_now
          @context[:time] = 'tomorrow'
          true
        elsif text.include? 'recommendation'
          @context[:type] = 'recommendation'
          true
        elsif text.include? 'quote'
          @context[:type] = 'quote'
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