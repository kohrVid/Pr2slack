class Pr2slackRailtie < Rails::Generators::Base
  source_root(File.expand_path(File.dirname(__FILE__))
config_ru = <<EOF EOF
Thread.abort_on_exception = true

Thread.new do
  begin
    Bot.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run Pr2slack::Bot
EOF
  def copy_initializer
    copy_file 'credentials.rb', 'config/initializers/pr2slack.rb'
    append_file 'config.ru', config_ru
    prepend_file 'config.ru', "require 'bot'"
    inject_into_file 'config.ru', config_ru, before: 'run Rails.application', verbose: false
  end
end
