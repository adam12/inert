require_relative "test_helper"
require "inert/page"

class TestPage < Minitest::Test
  def test_load_from_file
    assert_raises Errno::ENOENT do
      Inert::Page.load_from_file("foobarbaz")
    end

    fixture = File.expand_path("example/views/index", __dir__)
    refute_nil Inert::Page.load_from_file(fixture)
  end

  def test_extracting_frontmatter
    body = <<~EOM
    ---
    title: The Post Title
    ---

    The post
    EOM

    body, frontmatter = Inert::Page.extract_frontmatter(body)

    assert_equal "The Post Title", frontmatter["title"]
  end
end
