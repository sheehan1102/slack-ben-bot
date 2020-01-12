class FormWeatherResponse

  def self.call(*args)
    self.new(*args).call
  end

  def initialize(forecast:, context: {})
    @forecast = forecast
    @context  = context
  end

  def call
    if @context[:time] == 'now'
      formatted_response('now')
    elsif @context[:time] == 'tomorrow'
      formatted_response('for tomorrow')
    end
  end

  private

    def formatted_response(time)
      description = @forecast["currently"]["summary"].downcase
      temp = @forecast["currently"]["temperature"].to_i
      "The weather #{time} is #{description} and #{temp} degrees."
    end

end