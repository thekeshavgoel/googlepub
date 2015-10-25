require File.expand_path(File.dirname(__FILE__) + '/lib/googlepub.rb')

Gem::Specification.new do |s|
  s.name        = 'googlepub'
  s.version     = Googlepub::VERSION
  s.date        = '2015-10-25'
  s.summary     = "GooglePlay App Publisher!"
  s.description = "Automate everything related to Google App Publishing, APK, Stor Listing and In-App Purchses."
  s.authors     = ["Keshav Goel"]
  s.email       = 'keshu_gl@yahoo.com'
  s.require_paths = ['lib']
  s.executables = ['googlepub']

  s.files = Dir['lib/**/*', 'bin/*','googlepub.gemspec'] + %w( README.md LICENSE )
  s.homepage    = 'https://github.com/thekeshavgoel/googlepub'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 1.9.2'
  s.add_runtime_dependency 'base64url', '~> 1.0'
  s.add_runtime_dependency 'jwt', '~> 1.5'
  s.add_runtime_dependency 'json-jwt', '~> 1'
  s.add_runtime_dependency 'httparty', '~> 0'
  s.add_runtime_dependency 'httmultiparty', '~> 0'
  s.add_runtime_dependency 'colorize', '~> 0'
end
