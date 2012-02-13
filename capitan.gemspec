# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "capitan/version"

Gem::Specification.new do |s|
  s.name        = "capitan"
  s.version     = Capitan::VERSION
  s.authors     = ["Ross Kaffenberger"]
  s.email       = ["rosskaff@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Deployment command center for ChallengePost}
  s.description = %q{Inspired by projects like Github's Heaven and Etsy's Deployinator, Capitan aims to provide
    an interface to ease the pain of deploying ChallengePost apps.
  }

  s.rubyforge_project = "capitan"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"

  s.add_dependency 'engineyard'
  s.add_dependency 'redis-namespace'
  s.add_dependency 'mustache'
  s.add_dependency 'sinatra'
  s.add_dependency 'sqlite3'
  s.add_dependency 'activesupport'
  s.add_dependency 'activerecord'

  # gem "json"
  # gem "pony"
  # gem "tlsmail"
  # gem "open4"

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'rack-test'

end
