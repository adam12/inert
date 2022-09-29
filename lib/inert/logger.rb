# frozen-string-literal: true

require "logger"

module Inert
  class Logger < ::Logger
    def self.configure(receiver, attr_meth = :logger)
      instance = new($stdout)
      receiver.public_send("#{attr_meth}=", instance)
      instance
    end
  end
end
