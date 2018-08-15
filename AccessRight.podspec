
Pod::Spec.new do |s|

  s.name = 'AccessRight'
  s.version = '1.0.0'
  s.swift_version = '4.2'
  s.summary = 'A right way to persist access to URLs between app launches'
  s.homepage = 'https://github.com/igormuzyka/AccessRight'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'igormuzyka' => 'igormuzyka42@gmail.com' }
  s.source = { :git => 'https://github.com/igormuzyka/AccessRight.git', :tag => s.version.to_s }
  s.source_files = 'Sources/*'

  s.osx.deployment_target = "10.11"
  s.ios.deployment_target  = "9.0"
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '3.0'

  s.dependency 'FileKit'
  s.dependency 'FileKit-RestorablePersistable'

end
