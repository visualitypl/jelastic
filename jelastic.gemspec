# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jelastic/version'

Gem::Specification.new do |spec|
  spec.name          = 'jelastic'
  spec.version       = Jelastic::VERSION
  spec.license       = 'MIT'
  spec.authors       = ['Marcin Prokop']
  spec.email         = ['m.prokop@visuality.pl']

  spec.summary       = %q{Ruby wrapper for Jelastic API}
  spec.homepage      = 'https://github.com/visualitypl/jelastic'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
end
