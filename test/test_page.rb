require "minitest/autorun"
require "pp"
require "fakefs"
require "inert/page"

describe Inert::Page do
  describe ".find_file" do
    it "returns file with any extension" do
      FakeFS do
        File.write("foo.erb", "hello")

        assert_equal "/foo.erb", Inert::Page.find_file("foo")
      end
    end
  end

  describe ".load_from_file" do
    it "strips frontmatter"
    it "loads body"
  end

  it "has default layout" do
    page = Inert::Page.new

    assert_equal "layout", page.layout
  end

  it "accepts any frontmatter" do
    page = Inert::Page.new

    page.frontmatter.name = "test"
    assert_equal "test", page.frontmatter.name
  end
end
