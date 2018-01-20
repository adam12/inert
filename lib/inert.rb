# frozen_string_literal: true
require_relative "inert/version"
require_relative "inert/config"

module Inert
  module_function

  def start
    app = Rack::Builder.app do
      if Inert.development?
        use Rack::ShowExceptions
        use Rack::CommonLogger
      end

      run Inert::Middleware
    end

    Rack::Server.start(app: app)
  end

  def build
    Inert::Builder.new(Inert::Middleware).call("/")
  end

  def view_path
    File.expand_path(Inert.config.views, Dir.pwd)
  end

  def development?
    ENV["RACK_ENV"] == "development"
  end

  def building?
    !development?
  end
end

require_relative "inert/page"
require_relative "inert/builder"
require_relative "inert/middleware"
