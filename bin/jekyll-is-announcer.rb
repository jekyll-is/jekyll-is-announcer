#!/usr/bin/ruby

require 'net/http'
require 'uri'
require 'json'

module AnnouncerBin

  class << self

    def telegram post, config
      bot_uri = URI("https://api.telegram.org/bot#{ENV['TELEGRAM_BOT_TOKEN']}/sendMessage")
      bot_msg = JSON.generate(
        {
          'chat_id' => config['chat_id'],
          'parse_mode' => 'MarkdownV2',
          'text' => telegram_message(post)
        }
      )
      
      http = Net::HTTP::new uri.host, uri.port
      http.use_ssl = true

      request = Net::HTTP::Post::new uri.path, 'Content-Type' => 'application/json'
      request.body = bot_msg

      response = http.request request

      if response.code != '200' && response.code != '201'
        warn "Error on telegram sendMessage, HTTP code = #{response.code}"
        return false
      end

      result = nil
      begin
        result = JSON.parse response.body
      rescue JSON::ParseError => e
        warn "JSON parse error: #{e.message}"
        return false
      end
      
      if !result['ok']
        warn "Bad result of sendMesage: #{response.body}"
        return false
      end
      
      "https://t.me/#{result['result']['chat']['username']}/#{result['result']['message_id']}"
    end

    def index_now post, config
      # TODO: implement
    end

    private

    def telegram_escape text
      special_chars = '_*[]()~`>#+-=|{}.!'
      pattern = Regexp.union(special_chars.chars)
      text.gsub(pattern) { |char| "\\#{char}" }
    end

    def telegram_message post
      [
        "*[#{telegram_escape(port['title'])}](#{post['url']})*",
        "",
        telegram_escape(post['description']),
        "",
        (post['categories'] || []).map { |c| '\#' + telegram_escape(c) }.join(' • '),
        ""
      ].join("\n")
    end

  end

end

announced_path = File.join '.', '_data', 'announcer.json'
announces_path = File.join '.', '/tmp/', 'announces.json'

if File.exists?(announces_path)
  announced = begin 
    JSON.load_file announced_path
  rescue Exception => e
    warn e.message
    {}
  end
  save_flag = false
  announces = JSON.load_file announces_path
  announces.each do |channel, anno_data|
    config = anno_data['config']
    next unless config && config['method']
    posts = anno_data['posts']
    posts.each do |key, value|
      result = AnnouncerBin.send config['method'], value, config
      if result
        announced[channel] ||= {}
        announced[channel][key] = result
        save_flag = true
      end
    end
  end
  File.write announced_path, JSON.pretty_generate(announced)
end
