Gem::Specification.new do |s|
  s.name        = 'googlepub'
  s.version     = '1.0.0'
  s.date        = '2015-10-25'
  s.summary     = "GooglePlay App Publisher!"
  s.description = "Automate everything related to Google App Publishing, APK, Stor Listing and In-App Purchses."
  s.authors     = ["Keshav Goel"]
  s.email       = 'keshu_gl@yahoo.com'
  s.require_paths = ['lib']
  s.executables = ['googlepub']

  s.files = Dir['lib/**/*', 'bin/*','googlepub.gemspec']
  s.homepage    = 'http://rubygems.org/gems/googlepub'
  s.license     = 'MIT'
end
