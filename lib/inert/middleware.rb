# frozen_string_literal: true
require "roda"

module Inert
  class Middleware < Roda
    plugin :render,
      cache: Inert.building?,
      views: Inert.config.views

    plugin :partials
    plugin :public, root: "static"
    plugin :content_for

    class_exec &Inert.config.app

    route do |r|
      r.public

      instance_exec(r, &Inert.config.routes)

      view_file = r.remaining_path.dup
      view_file << "index.html" if view_file.end_with?("/")

      begin
        page = Page.load_from_file(File.join(Inert.view_path, view_file))
      rescue Errno::ENOENT
        r.halt([404, {}, ["#{view_file} Not found"]])
      end

      @page = page.frontmatter

      view(inline: page.body, layout: page.layout, template_class: Tilt[page.filename])
    end

    class_exec &Inert.config.helpers

    def inline(file)
      File.read(File.join(Inert.view_path, file))
    end

    def page
      @page ||= OpenStruct.new
    end
  end
end

