require_relative "test_helper"
require "inert/history"

class TestHistory < Minitest::Test
  def test_add_history
    history = Inert::History.new
    history.add "/"

    assert_equal 1, history.length
  end

  def test_history_presence
    history = Inert::History.new
    history.add "/"

    assert history.include?("/"), "Should of included our URL"
  end
end
