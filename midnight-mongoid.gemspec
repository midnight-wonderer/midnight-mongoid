lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'midnight/mongoid/version'

Gem::Specification.new do |spec|
  spec.name = 'midnight-mongoid'
  spec.version = Midnight::Mongoid::VERSION
  spec.author = 'Sarun Rattanasiri'
  spec.email = 'midnight_w@gmx.tw'
  spec.license = 'BSD-3-Clause'

  spec.summary = 'A MongoDB integration of Midnight::BusinessLogic'
  spec.description = 'This gem provides the integration between Midnight::BusinessLogic '\
    'and the ODM officially supported by MongoDB Inc., Mongoid'
  spec.homepage = 'https://slime.systems/'
  spec.metadata = {
    'homepage_uri' => spec.homepage,
    'source_code_uri' => "https://github.com/rails/rails/tree/v#{Midnight::Mongoid::VERSION}"
  }

  spec.files = Dir['lib/**/*']
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'midnight-business_logic'
  spec.add_dependency 'mongoid', '>= 7.0.0'
end
