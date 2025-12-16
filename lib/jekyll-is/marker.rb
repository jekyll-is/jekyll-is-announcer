
require 'set'
require 'liquid'
require 'jekyll'
require 'is-ial-parser'
require 'is-static-files'

module JekyllIS

  class AnnounceLink < Liquid::Tag

    def initialize tag, text, token
      super
      @tag = tag
      @text = text
      @token = token
      @params = IALParser::parse @text
    end

    def render context
      channel = @params[:channel]
      title   = @params[:title] || @params[:caption]
      caption = @params[:caption] || @params[:title]
      page = context.registers[:page]
      key = page['path']
      result = "<div markdown='span' class='announcer-block announcer-channel-#{channel}' style='display:none;' data-key='#{key}' data-channel='#{channel}'></div>"
      result += "\n<script src='/js/announcer.js'></script>" if once?(key)
      result
    end

    private

    def once? key
      @@keys ||= Set[]
      result = !@@keys.include?(key)
      @@keys << key
      result
    end

  end

end

Liquid::Template::register_tag 'announce_link', JekyllIS::AnnounceLink

Jekyll::Hooks::register :site, :post_read do |site|
  js_path = File.expand_path '../../assets/announcer.js', __dir__
  js_file = IS::StaticFile::new site, '/js/', 'announcer.js', source: js_path
  site.static_files << js_file
end
