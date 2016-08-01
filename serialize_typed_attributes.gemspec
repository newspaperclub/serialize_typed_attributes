$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "serialize_typed_attributes"
  s.version     = "0.1.0"
  s.authors     = ["Tom Taylor"]
  s.email       = ["tom@newspaperclub.com"]
  s.homepage    = "https://github.com/newspaperclub/serialize_typed_attributes"
  s.summary     = "Attribute getters and setters for serialized hashes in ActiveRecord."

  s.files = Dir["lib/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "activesupport", "~> 4.1"
  s.add_dependency "activerecord", "~> 4.1"

  s.add_development_dependency "test-unit"
  s.add_development_dependency "pg"
  s.add_development_dependency "activerecord-postgres-hstore", ">= 0.7.6"
end
