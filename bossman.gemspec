Gem::Specification.new do |s|
  s.name = "bossman"
  s.version = "0.0.5"
  s.date = "2008-08-17"
  s.summary = "Class for interaction with the Yahoo BOSS web service."
  s.email = "jpignata@waterfrontmedia.com"
  s.homepage = "http://github.com/jpignata/bossman-gem"
  s.authors = ["Jay Pignata"]
  s.files = ['bossman.gemspec', 'lib/bossman.rb', 'lib/bossman/basevalueobject.rb', 
    'lib/bossman/rest.rb', 'lib/bossman/result.rb', 'lib/bossman/resultset.rb', 
    'lib/bossman/search.rb', 'README', 'LICENSE']
  s.add_dependency("activesupport", [">= 2.1.0"])
  s.has_rdoc = false
end
