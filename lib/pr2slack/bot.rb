require 'slack-ruby-bot'

module Pr2slack
  class Bot < SlackRubyBot::Bot
    scan(/.*/) do |client, data, match|
      #SLACK_API_TOKEN = SLACK_API_TOKEN
      header = { Authorization: "token #{GITHUB_AUTH_TOKEN}" }
      req = Net::HTTP::Get.new(
        "https://api.github.com/repos/#{REPO_OWNER}/#{REPO_NAME}/pulls", initheader = header 
      )
      res = Net::HTTP.start("https://api.github.com", "80") do |http|
	http.request(req)
      end
      puts JSON.parse(res.body)
      #output_to_slack(message, client, data)
    end
    
    def self.output_to_slack(message, client, data)
      client.say(text: message, channel: data.channel)
    end
  end
end
