# frozen_string_literal: true
require "yaml"
require "ostruct"

module Inert
  class Page
    attr_reader :body, :frontmatter, :layout

    def initialize(body: "", frontmatter: {})
      @body = body
      @frontmatter = frontmatter
      @layout = @frontmatter.delete(:layout) || "layout"

      @frontmatter = OpenStruct.new(@frontmatter)
    end

    def self.load_from_file(filename)
      body = File.read(filename)
      frontmatter = {}

      body = body.gsub(/---(.*)---/m) do |m|
        frontmatter = YAML.load($1)
        ""
      end.lstrip

      new(body: body, frontmatter: frontmatter)
    end
  end
end
