begin
  require 'rubygems'
rescue Exception
  puts 'RubyGems is not installed. See http://www.rubygems.org/read/chapter/3 for instructions.'
end

begin
  require 'spec/rake/spectask'

  Spec::Rake::SpecTask.new do |t|
    t.spec_opts = ['-c']
    t.libs << 'lib'
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.rcov = true 
  end
rescue Exception 
  puts 'RSpec not available. Install it with: sudo gem install rspec'
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "bitfields"
    s.summary = "Simple named bit fields"
    s.description = "A very simple library for building binary data by declaring named bit fields"
    s.email = 'sanderjd@gmail.com'
    s.homepage = 'http://github.com/jsanders/bitfields'
    s.authors = ['James Sanders']
    s.has_rdoc = true
    s.files = ["README",
               "Rakefile",
               "demo.rb",
               "lib/bitfields.rb", 
               "lib/bits.rb"]
  end
rescue LoadError
  puts 'Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com'
end
