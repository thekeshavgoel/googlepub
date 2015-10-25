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
  s.add_dependency 'base64', '~> 1.0', '>= 1.0.1'
  s.add_dependency 'jwt', '~> 1.5', '>= 1.5.1'
  s.add_dependency 'jwt/json', '~> 0'
  s.add_dependency 'httparty', '~> 0.13.5'
  s.add_dependency 'httmultiparty', '~> 0.13.6'
  s.add_dependency 'openssl', '~> 0.9.4'
  s.add_dependency 'colorize', '~> 0.7.7'
end
