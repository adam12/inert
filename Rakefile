require "rubygems/tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList["test/**/test_*.rb"]
  t.warning = false
end

Gem::Tasks.new

task default: :test
