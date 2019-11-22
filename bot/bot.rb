require 'slack-ruby-bot'

class Bot < SlackRubyBot::Bot
  command 'ping' do |client, data, match|
    client.say(text: 'pong', channel: data.channel)
  end
end

Bot.run
