def slack_bot_mention
  {
    "token"=>"xxxxxxxxxxxxxxxxxxx",
    "team_id"=>"XXXXXX",
    "api_app_id"=>"XXXXXX",
    "event"=>{
      "client_msg_id"=>"xxxxxx-xxxxxxx-xxxxxxx-xxxxx",
      "type"=>"app_mention",
      "text"=>"<@XXXXXXXX> sorry, had to save changes :stuck_out_tongue_winking_eye:",
      "user"=>"XXXXXXXX",
      "ts"=>"1578856310.001500",
      "team"=>"XXXXXXXX",
      "blocks"=>[{
        "type"=>"rich_text",
        "block_id"=>"F35EF",
        "elements"=>[{
          "type"=>"rich_text_section",
          "elements"=>[{
            "type"=>"user",
            "user_id"=>"xxxxxxx"
          }, {
            "type"=>"text",
            "text"=>" sorry, had to save changes "
          }, {
            "type"=>"emoji",
            "name"=>"stuck_out_tongue_winking_eye"
          }]
        }]
      }],
      "channel"=>"XXXXXXXX",
      "event_ts"=>"1578856310.001500"
    },
    "type"=>"event_callback",
    "event_id"=>"XXXXXXXX",
    "event_time"=>1578856310,
    "authed_users"=>["XXXXXXXX"],
    "slack_webhook"=>{
      "token"=>"xxxxxxxxxxxxxx",
      "team_id"=>"XXXXXXXX",
      "api_app_id"=>"XXXXXXXX",
      "event"=>{
        "client_msg_id"=>"xxxxxx-xxxxxxx-xxxxxxx-xxxxx",
        "type"=>"app_mention",
        "text"=>"<@XXXXXXXX> sorry, had to save changes :stuck_out_tongue_winking_eye:",
        "user"=>"XXXXXXXX",
        "ts"=>"1578856310.001500",
        "team"=>"XXXXXXXX",
        "blocks"=>[{
          "type"=>"rich_text",
          "block_id"=>"F35EF",
          "elements"=>[{
            "type"=>"rich_text_section",
            "elements"=>[{
              "type"=>"user",
              "user_id"=>"XXXXXXXX"
            }, {
              "type"=>"text",
              "text"=>" sorry, had to save changes "
            }, {
              "type"=>"emoji",
              "name"=>"stuck_out_tongue_winking_eye"
            }]
          }]
        }],
        "channel"=>"XXXXXXXX",
        "event_ts"=>"1578856310.001500"
      },
      "type"=>"event_callback",
      "event_id"=>"XXXXXXXX",
      "event_time"=>1578856310,
      "authed_users"=>["XXXXXXXX"]
    }
  }
end