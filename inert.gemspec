Gem::Specification.new do |spec|
  spec.name = "inert"
  spec.version = "0.2.0"
  spec.authors = ["Adam Daniels"]
  spec.email = "adam@mediadrive.ca"

  spec.summary = %q(An experimental static site builder with unambitious goals)
  spec.homepage = "https://github.com/adam12/inert"
  spec.license = "MIT"

  spec.files = ["README.md"] + Dir["lib/**/*.rb"]
  spec.bindir = "exe"
  spec.executables << "inert"

  spec.add_dependency "roda", ">= 2.0", "< 4.0"
  spec.add_dependency "tilt", ">= 2.0", "< 4.0"
  spec.add_dependency "oga", ">= 2.0", "< 4.0"
end
