Gem::Specification.new do |s|
  s.name = "bossman"
  s.version = "0.0.1"
  s.date = "2008-08-10"
  s.summary = "Library for interaction with the Yahoo BOSS web service."
  s.email = "jpignata@waterfrontmedia.com"
  s.homepage = "http://github.com/jpignata/bossman"
  s.description = "Library for interaction with the Yahoo BOSS web service."
  s.authors = ["John Pignata"]
  s.files = ["README", "bossman.gemspec", "lib/bossman.rb"]
  s.add_dependency("httparty", [">= 0.1.2"])
  s.has_rdoc = false
end
