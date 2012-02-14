# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lingual/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Sam Soffes']
  gem.email         = ['sam@samsoff.es']
  gem.description   = 'Temporary localization for Objective-C projects'
  gem.summary       = 'Temporary localization for Objective-C projects. Say you added some strings at the last minute and don\'t have time to get them translated. Simply run `lingual` to automatically detect missing strings and Google Translate them.'
  gem.homepage      = 'https://github.com/samsoffes/lingual'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'lingual'
  gem.require_paths = ['lib']
  gem.version       = Lingual::VERSION
  
  gem.add_dependency 'google_translate'
end
