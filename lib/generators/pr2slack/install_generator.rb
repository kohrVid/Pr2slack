require 'rails/generators/base'
module Pr2slack
  class InstallGenerator < Rails::Generators::Base
    source_root(File.expand_path(File.dirname(__FILE__)))
    def initialiser
      <<EOF
Pr2slack.configure do |config|
  config.REPO_OWNER = "REPO_OWNER"
  config.REPO_NAME = "REPO_NAME"
  config.GITHUB_AUTH_TOKEN = "GITHUB_AUTH_TOKEN"
  config.SLACK_API_TOKEN = "SLACK_API_TOKEN"


  ENV["SLACK_API_TOKEN"] = config.SLACK_API_TOKEN
end
EOF
    end

    def config_ru
    <<EOF

Thread.abort_on_exception = true

Thread.new do
  begin
    Pr2slack::Bot.run
  rescue Exception => e
    STDERR.puts "ERROR: \#{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run Pr2slack::Bot
EOF
    end
    desc "Generates initial files for Pr2slack"
    def copy_initializer
      create_file 'config/initializers/pr2slack.rb', initialiser
      prepend_file 'config.ru', "require 'pr2slack/bot'\n"
      inject_into_file 'config.ru', config_ru, before: 'run Rails.application'
    end
  end
end
