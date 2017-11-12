# frozen_string_literal: true
require_relative "inert/config"

module Inert
  module_function

  def start
    app = Inert::Middleware

    if ENV["RACK_ENV"] != "production"
      app = Rack::ShowExceptions.new(app)
    end

    Rack::Server.start(app: app)
  end

  def build
    Inert::Builder.new(Inert::Middleware).call("/")
  end
end

require_relative "inert/page"
require_relative "inert/builder"
require_relative "inert/middleware"
