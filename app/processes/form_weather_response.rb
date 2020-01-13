class FormWeatherResponse

  def self.call(*args)
    self.new(*args).call
  end

  def initialize(forecast:, context: {})
    @forecast    = forecast
    @context     = context
    @icon        = forecast["currently"]["icon"]
    @temperature = forecast["currently"]["temperature"]
  end

  def call
    if @context[:time] == 'now'
      formatted_time_response('now')
    elsif @context[:time] == 'tomorrow'
      formatted_time_response('for tomorrow')
    elsif @context[:type] == 'recommendation'
      recommendation_response
    elsif @context[:type] == 'quote'
      weather_quotes.sample
    end
  end

  private

    def description
      @icon.sub('-day', '').sub('-night', '').sub('-', ' ')
    end

    def formatted_time_response(time)
      temp = @temperature.to_i
      "The weather #{time} is #{description} and #{temp} degrees."
    end

    def recommendation_response
      advice = if @icon.include?('clear') && @temperature >= 55
                "it's a lovely day; you should take a hike, a bike, or play golf!"
              elsif @icon.include?('clear') && @temperature < 55
                "bundle up and take a snowshoe; or, if you have no snow, walk the dog and watch the sunrise!"
              elsif @icon == 'snow'
                "it's snowing; get out on some skis!"
              elsif @icon == 'wind'
                "be careful: you may get blown away out there!"
              elsif @icon == 'fog'
                "the setting of many a horror movie..."
              elsif ['rain', 'sleet'].include? @icon
                "it's nasty out there; good day to be cozy inside!"
              elsif @icon == 'cloudy'
                "at least you won't get burned out there... or will you?"
              else
                "IDK lol; ben-bot can't help you with everything!"
              end
      "#{description.capitalize}: #{advice}"
    end

end