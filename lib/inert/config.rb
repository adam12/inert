# frozen_string_literal: true
module Inert
  # Configure your Inert build by creating an Inertfile in the project root,
  # and call Inert.config with a block which receives the inert config instance.
  #
  # This config instance allows you to access the Roda application underneath,
  # configuring plugins, helpers, and adding routes that run prior to the catch-all.
  #
  #   Inert.config do |inert|
  #     inert.helpers do
  #       def generator
  #         "Inert v#{Inert::VERSION}"
  #       end
  #     end
  #
  #     inert.app do
  #       plugin :h
  #     end
  #
  #     inert.routes do |r|
  #       r.on "employees.html" do
  #         @employees = [] # Read in actual data here
  #         view("employees.html.erb")
  #       end
  #     end
  #   end
  class Config
    # Folder containing your pages or view files.
    attr_accessor :views

    def initialize
      @app = proc{}
      @helpers = proc{}
      @routes = proc{}
      @views = "views"
    end

    # Helpers to make available in your views.
    # Pass a module to be included, or a block to be evaluates.
    def helpers(value=nil, &block)
      @helpers = ->{ include value } if value
      @helpers = block if block_given?
      @helpers
    end

    # Configuration changes on the underlying Roda app.
    # Pass a block which will be class evaled.
    def app(&block)
      return @app unless block_given?
      @app = block
    end

    # Extra routes that run before the catch-all route (but after the assets route).
    # Pass a block which will be instance evaluated.
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
