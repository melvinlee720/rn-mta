require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = package['name']
  s.version      = package['version']
  s.summary      = 'rn-mta'
  s.description  = package['description']
  s.license      = package['license']
  s.author       = package['author']
  s.platform      = :ios, "9.0"
  s.homepage     = package['homepage']
  s.source       = { :git => package['repository']['url'], :tag => package['version'] }
  s.source_files = 'ios/rnmta.{h,m}'
  s.requires_arc = true
  s.frameworks = "AdSupport", "CFNetwork", "SystemConfiguration", "CoreTelephony"
  s.libraries = "libz", "libsqlite3"

  s.dependency 'React'
end
