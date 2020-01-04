require_relative "test_helper"
require "fileutils"
require "inert"

class TestBuilding < Minitest::Test
  def test_builds_site
    build_destination = Dir.mktmpdir("inert")

    Dir.chdir(File.expand_path("example", __dir__)) do
      require "inert/app"
      Inert::Builder.new(Inert::App, build_destination: build_destination).call("/")

      assert_equal "Index", File.read(File.expand_path("index.html", build_destination)).strip
    end
  ensure
    FileUtils.remove_entry(build_destination) if build_destination
  end
end
