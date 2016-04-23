@version = "0.0.2"

Pod::Spec.new do |s|
  s.name         = 'TWKit'
  s.version      = @version
  s.summary      = 'TWKit'
  s.homepage     = 'https://github.com/taewan0530/TWKit'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'taewan' => 'taewan0530@daum.net' }
  s.source       = { :git => 'https://github.com/taewan0530/TWKit.git', :tag => @version }
  s.source_files = 'Pod/**/*.{swift}'
  
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
end