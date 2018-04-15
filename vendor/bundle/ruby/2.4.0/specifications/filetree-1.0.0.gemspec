# -*- encoding: utf-8 -*-
# stub: filetree 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "filetree".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Eric West".freeze]
  s.date = "2013-05-27"
  s.description = "A simple tree structure for working with FilePath objects in ruby. I simply took the simple_tree module from https://github.com/ealdent/simple-tree and hacked it into Pathname (http://www.ruby-doc.org/stdlib-2.0/libdoc/pathname/rdoc/Pathname.html) from the std-lib. This means you get all the awesome features of working with Pathname, as well as making it easy to examine a filepath's ancestors and descendants.".freeze
  s.email = "esw9999@gmail.com".freeze
  s.homepage = "https://github.com/edubkendo/FileTree".freeze
  s.licenses = ["BSD".freeze]
  s.rubygems_version = "2.6.11".freeze
  s.summary = "A simple ruby library for manipulating filepaths as tree structures".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version
end
