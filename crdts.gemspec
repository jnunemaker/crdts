# -*- encoding: utf-8 -*-
require File.expand_path('../lib/crdts/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["John Nunemaker"]
  gem.email         = ["nunemaker@gmail.com"]
  gem.description   = %q{TODO: Convergent replicated data types.}
  gem.summary       = %q{TODO: Convergent replicated data types.}
  gem.homepage      = "http://github.com/jnunemaker/crdts"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "crdts"
  gem.require_paths = ["lib"]
  gem.version       = Crdts::VERSION
end
