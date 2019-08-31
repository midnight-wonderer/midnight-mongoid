lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'midnight/mongoid/version'

Gem::Specification.new do |spec|
  spec.name = 'midnight-mongoid'
  spec.version = Midnight::Mongoid::VERSION
  spec.author = 'Sarun Rattanasiri'
  spec.email = 'midnight_w@gmx.tw'

  spec.summary = 'A MongoDB integration of Midnight::BusinessLogic'
  spec.description = 'This library provides the integration of Midnight::BusinessLogic '\
    'and MongoDB like databases backed by the officially supported ODM, Mongoid'
  spec.homepage = 'https://github.com/midnight-wonderer'
  spec.metadata = {
    'homepage_uri' => spec.homepage,
    # 'source_code_uri' => "https://gitlab.com/slime-systems/midnight-enterprise-toolkit/tree/v#{version}/midnight-business_logic"
  }

  spec.files = Dir['lib/**/*']
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'midnight-business_logic'
  spec.add_dependency 'mongoid', '>= 7.0.0'
end
