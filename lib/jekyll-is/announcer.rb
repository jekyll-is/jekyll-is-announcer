
require 'fileutils'
require 'date'
require 'json'
require 'jekyll'
require 'is-static-files'

module JekyllIS

  class Announcer < Jekyll::Generator

    attr_reader :site
    attr_reader :config
    attr_reader :data
    attr_reader :announces

    CHANNELS = Set['telegram', 'index_now']

    def generate site
      @site = site
      
      @config = @site.config['announcer']
      return nil unless @config
      raise ArgumentError, "Invalid announcer config format" unless Hash === @config

      @data = @site.data['announced'] || {}
      @config.each do |key, _|
        @data[key] ||= {}
      end

      @announces = {}
      process_posts
      publish_announced_file
      generate_announces_file
    end

    private

    def get_categories doc
      config = @config['categories'] || {}
      categories = doc.data['categories'] || doc.data['category']
      categories.filter_map do |category|
        next if config[category] == false || config[category] == 'false' || config[category] == 'skip'
        config[category] || category
      end
    end

    def process_posts
      @site.posts.docs.select { |d| d.data['announce'] }.each do |doc|
        key = doc.relative_path
        CHANNELS.each do |channel|
          next unless @config[channel]
          channel_data = @data[channel] || {}
          unless channel_data[key]
            @announces[channel] ||= { 'config' => @config[channel], 'posts' => {} }
            @announces[channel]['posts'][key] = {
              'url' => @config['url'] + doc.url,
              'date' => doc.date.strftime('%Y/%m/%d'),
              'title' => doc.data['title'],
              'description' => doc.data['description'],
              'categories' => get_categories(doc)
            }
          end
        end
      end
    end

    def publish_announced_file
      if @site.data['announced']
        src = File.join @site.source, '_data', 'announced.json'
        @site.static_files << IS::StaticFile::new(@site, '/data/', 'announced.json', source: src)
      else
        @site.static_files << IS::StaticFile::new(@site, '/data/', 'announced.json', content: '{}')
      end
    end

    def generate_announces_file
      target = File.join @site.source, '.announces.json'
      File.write target, JSON.pretty_generate(@announces)
    end

  end

end
