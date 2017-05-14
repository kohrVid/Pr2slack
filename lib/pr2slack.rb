require "json"
#require "forwardable"
require "uri"
require "net/http"
require "pry"

require "pr2slack/bot"
require "pr2slack/version"

module Pr2slack
  class << self
    attr_accessor :configuration, :scan
    #extend Forwardable
#    def_delegators :configure

  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :REPO_OWNER, :REPO_NAME, :GITHUB_AUTH_TOKEN, :SLACK_API_TOKEN

    def initialize
      @REPO_OWNER = "REPO_OWNER"
      @REPO_NAME = "REPO_NAME"
      @GITHUB_AUTH_TOKEN = ""
      @SLACK_API_TOKEN = "SLACK_API_TOKEN"
    end
  end
end
