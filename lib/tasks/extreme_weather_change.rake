desc 'Ping for extreme weather change; notify channel of extremes'
task extreme_weather_change: :environment do
  yesterday_forecast = DarkSkyService.get_forecast(1.day.ago)
  today_forecast = DarkSkyService.get_current_forecast

  temp_difference = today_forecast["currently"]["temperature"].to_i - yesterday_forecast["currently"]["temperature"].to_i

  if temp_difference.abs >= Figaro.env.temperature_change_minimum.to_i
    temp_direction = temp_difference > 0 ? 'warmer' : 'colder'
    message = "<!channel> Look out! It's going to be so much #{temp_direction} than yesterday!"
    SlackBotService.post_message(message)
  end
end