require "json"
require "forwardable"
require "uri"
require "net/http"

require "pr2slack/bot"
require "pr2slack/version"

module Pr2slack
  class << self
    extend Forwardable
    def_delegators :scan

  end
end
