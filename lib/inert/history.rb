# frozen-string-literal: true

require "set"
require "forwardable"

module Inert
  class History
    extend Forwardable

    def initialize
      @entries = Set.new
    end

    def_delegator :@entries, :add
    def_delegator :@entries, :include?
    def_delegator :@entries, :length
  end
end
