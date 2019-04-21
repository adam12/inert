# frozen_string_literal: true
require_relative "inert/version"
require_relative "inert/config"
require_relative "inert/cli"

module Inert
  module_function

  def start(server: nil, host: nil, port: nil)
    require_relative "inert/app"

    app = Rack::Builder.app do
      if Inert.development?
        use Rack::CommonLogger
      end

      run Inert::App
    end

    Rack::Server.start({
      app: app,
      server: server,
      "Host": host,
      "Port": port
    })
  end

  def build
    require_relative "inert/app"

    Inert::Builder.new(Inert::App).call("/")
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
