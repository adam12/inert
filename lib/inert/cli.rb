# frozen-string-literal: true

require "thor"

module Inert
  class CLI < Thor
    default_command :server

    desc "build", "Build site"
    def build
      ENV["RACK_ENV"] = "production"
      Inert.build
    end

    desc "server", "Run server"
    method_option :port, aliases: "-p", desc: "port to listen on", type: :numeric, default: 3000
    method_option :bind, aliases: "-b", desc: "address to listen on", type: :string, default: "localhost"
    method_option :server, aliases: "-s", desc: "server to use", type: :string
    def server
      ENV["RACK_ENV"] = "development"
      Inert.start(server: options.server, host: options.bind, port: options.port)
    end
  end
end
