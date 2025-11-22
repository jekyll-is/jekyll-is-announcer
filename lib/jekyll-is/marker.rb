
require 'set'
require 'liquid'
require 'is-ial-parser'

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
      result = "<div class='.announcer-block' style='display:none;' data-key='#{key}' data-channel='#{channel}'><a href='#' title='#{title}'>#{caption}</a></div>"
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
