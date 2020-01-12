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
    end
  end

  private

    def formatted_time_response(time)
      description = @icon.sub('-day', '').sub('-night', '').sub('-', ' ')
      temp = @temperature.to_i
      "The weather #{time} is #{description} and #{temp} degrees."
    end

    def recommendation_response
      if @icon.include?('clear') && @temperature >= 55
        "It's a lovely day; you should take a hike, a bike, or play golf!"
      elsif @icon == 'snow'
        "It's snowing; get out on some skis!"
      elsif ['rain', 'sleet'].include? @icon
        "It's nasty out there; good day to be cozy inside!"
      else
        "IDK lol; ben-bot can't help you with everything!"
      end
    end

end