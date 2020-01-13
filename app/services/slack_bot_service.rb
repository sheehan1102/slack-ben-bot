module SlackBotService
  extend self

  BASE_URL = "https://slack.com/api"
  CHANNEL_ID = "GS6KVDC8K"

  def post_message(text)
    body = { "text": text, "channel": CHANNEL_ID }
    url = "#{BASE_URL}/chat.postMessage"
    HTTParty.post(url, body: body, headers: api_auth_header)
  end

  private

    def api_auth_header
      { "Authorization" => "Bearer #{Figaro.env.slack_api_token}" }
    end

end