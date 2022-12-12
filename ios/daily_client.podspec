#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint daily_client.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'daily_client'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://teamflowhq.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Teamflow' => 'danilo@teamflowhq.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  # s.dependency 'Daily'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  
  # Daily local version
  s.preserve_paths = 'Daily.xcframework/**/*'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework Daily' }
  s.vendored_frameworks = 'Daily.xcframework'
end
