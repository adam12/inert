# frozen_string_literal: true
require_relative "inert/page"
require_relative "inert/scraper"
require_relative "inert/middleware"

module Inert
  module_function

  def start
    app = Inert::Middleware

    if ENV["RACK_ENV"] != "production"
      app = Rack::ShowExceptions.new(app)
    end

    Rack::Server.start(app: app)
  end

  def scrape
    Inert::Scraper.new(Inert::Middleware).call("/")
  end
end
