require 'slack-ruby-bot'
require "pry"

module Pr2slack
  class Bot < SlackRubyBot::Bot

    scan(/.*/) do |client, data, match|
          puts "hello"
      #called = true
      #while 0 < 1
      repo_owner = Pr2slack.configuration.REPO_OWNER
      repo_name = Pr2slack.configuration.REPO_NAME
      github_auth_token = Pr2slack.configuration.GITHUB_AUTH_TOKEN
      header = { Authorization: "token #{github_auth_token}" }
      uri = URI.parse("https://api.github.com/repos/#{repo_owner}/#{repo_name}/pulls")
      #http = Net::HTTP.new(uri.host, uri.port).start
      #req = Net::HTTP::Get.new(uri.request_uri, header)
      #res = http.request(req)
      res = Net::HTTP.get_response(uri)
      @last_pr = {}
      #if res.
      if !res.body.empty?
        pull_request = JSON.parse(res.body).sort_by do |pr| 
          pr["updated_at"]
        end.last
        message = format_message(pr)
          client.say(text: "hello", channel: data.channel)

        if pr == @last_pr
          puts "mew"
        else
          client.say(text: message, channel: data.channel)
          @last_pr = pr
        end
      end
      #end
    end
    
    def self.format_message(pr)
      <<EOF
Pull Request ##{ pr["number"] } was updated at #{pr["updated_at"]}
#{pr["url"]}
      #{ "It was merged at #{ pr["merged_at"] }" unless pr["merged_at"].nil? }
EOF
    end
  end
end
