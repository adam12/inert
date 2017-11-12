# frozen_string_literal: true
module Inert
  class Config
    def initialize
      @app = proc{}
      @helpers = proc{}
      @routes = proc{}
    end

    def helpers(value=nil, &block)
      @helpers = ->{ include value } if value
      @helpers = block if block_given?
      @helpers
    end

    def app(&block)
      return @app unless block_given?
      @app = block
    end

    def routes(&block)
      return @routes unless block_given?
      @routes = block
    end
  end

  module_function
  def config
    @config ||= Config.new
    yield @config if block_given?
    @config
  end
end
