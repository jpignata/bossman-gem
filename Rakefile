require 'rake'
require 'spec/rake/spectask'
require "rake/gempackagetask"

task :default => [:spec]

spec = Gem::Specification.new do |s|
  s.name      = "bossman"
  s.version   = "0.2.0"
  s.date      = "2009-08-20"
  s.summary   = "Gem for interaction with the Yahoo BOSS web service."
  s.email     = "john.pignata@gmail.com"
  s.homepage  = "http://github.com/jpignata/bossman-gem"
  s.authors   = ["Jay Pignata"]
  s.files     = ['lib/bossman.rb', 'lib/bossman/base_value_object.rb', 
                  'lib/bossman/boss.rb', 'lib/bossman/result.rb', 'lib/bossman/result_set.rb', 
                  'lib/bossman/search.rb', 'README.md', 'LICENSE']
  s.has_rdoc  = false
  s.add_dependency("activesupport", [">= 2.1.0"])
end

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/*_spec.rb']
  t.spec_opts = ['--color', '--format specdoc']
end

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
end