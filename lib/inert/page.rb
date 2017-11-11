# frozen_string_literal: true
require "yaml"
require "ostruct"

module Inert
  class Page
    attr_reader :body, :frontmatter, :layout, :filename

    def initialize(body: "", frontmatter: {}, filename: nil)
      @body = body
      @frontmatter = frontmatter
      @layout = @frontmatter.delete("layout") || "layout"
      @filename = filename

      @frontmatter = OpenStruct.new(@frontmatter)
    end

    def self.load_from_file(filename)
      filename = find_file(filename)

      raise Errno::ENOENT if filename.nil?

      body = File.read(filename)
      frontmatter = {}

      body = body.gsub(/---(.*)---/m) do |m|
        frontmatter = YAML.load($1)
        ""
      end.lstrip

      new(body: body, frontmatter: frontmatter, filename: filename)
    end

    def self.find_file(filename)
      Dir[filename + ".*"].first
    end
  end
end
