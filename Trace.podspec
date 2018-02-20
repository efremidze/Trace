Pod::Spec.new do |s|
  s.name             = 'Trace'
  s.version          = '0.0.1'
  s.summary          = 'Easy Custom Gestures'
  s.homepage         = 'https://github.com/efremidze/Trace'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'efremidze' => 'efremidzel@hotmail.com' }
  s.source           = { :git => 'https://github.com/efremidze/Trace.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Sources/*.swift'
end
