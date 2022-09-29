require_relative "test_helper"
require "fileutils"
require "open3"

class TestCli < Minitest::Test
  def test_build
    build_destination = Dir.mktmpdir("inert")

    # TODO: Specify build destination option to CLI
    exe = File.expand_path("../exe/inert", __dir__)
    lib = File.expand_path("../lib", __dir__)

    Dir.chdir(File.expand_path("example", __dir__)) do
      output, status = Open3.capture2e("ruby -W0 -I#{lib} #{exe} build")
      assert_match %r{Saving /}, output.strip
      assert_equal 0, status.exitstatus
    end
  ensure
    FileUtils.remove_entry(build_destination) if build_destination
  end
end
