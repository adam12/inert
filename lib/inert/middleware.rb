# frozen_string_literal: true
require "roda"

module Inert
  class Middleware < Roda
    plugin :render
    plugin :public, root: "static"

    attr_reader :page

    route do |r|
      r.public

      view_file = r.remaining_path.dup
      view_file << "index.html" if view_file.end_with?("/")

      # TODO: Check file existance or rescue exception?
      page = Page.load_from_file("./views#{view_file}.erb")
      @page = page.frontmatter

      view(inline: page.body, layout: page.layout)
    end
  end
end

