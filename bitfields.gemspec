# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bitfields}
  s.version = "0.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Sanders"]
  s.date = %q{2009-02-23}
  s.description = %q{A very simple library for building binary data by declaring named bit fields}
  s.email = %q{sanderjd@gmail.com}
  s.files = ["README", "Rakefile", "demo.rb", "lib/bitfields.rb", "lib/bits.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/jsanders/bitfields}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Simple named bit fields}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
