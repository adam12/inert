# frozen_string_literal: true
require "fileutils"
require "set"
require "oga"
require "uri"

module Inert
  class Builder
    attr_accessor :app, :build_path
    attr_reader :queue, :history

    def initialize(app)
      @app = app
      @queue = []
      @history = Set.new
      @build_path = "./build"
    end

    def call(starting_url)
      save(starting_url)
      history.add(starting_url)

      while (url = queue.pop)
        next if already_visited?(url) || is_anchor?(url) || is_remote?(url)

        save(url)
        history.add(url)
      end
    end

    def save(url)
      warn "Saving #{url}"
      request = Rack::MockRequest.new(app)

      dest = URI(url.dup).path
      dest << "index.html"  if dest.end_with?("/")
      dest << ".html"       unless dest =~ /\.\w+$/
      dest = File.expand_path(dest[1..-1], build_path)

      FileUtils.mkdir_p(File.dirname(dest))

      response = request.get(url)
      return unless response.ok?

      File.write(dest, response.body)
      return unless response.content_type == "text/html"

      html = Oga.parse_html(response.body)
      html.css("[href], [src]").each do |el|
        url = (el.get("href") || el.get("src"))

        next if url =~ /\Ahttps?/

        queue.push(url)
      end

      html.css("[style*='url']").each do |el|
        el.get("style").match(/url\(['"]?([^'"]+)['"]?\)/) do |m|
          queue.push(m[1])
        end
      end
    end

    def already_visited?(url)
      history.include?(url)
    end

    def is_anchor?(url)
      url.start_with?("#")
    end

    def is_remote?(url)
      url =~ /\A(\w+):/ || url.start_with?("//")
    end
  end
end
