@version = "0.0.4"

Pod::Spec.new do |s|
  s.name         = 'TWKit'
  s.version      = @version
  s.summary      = 'TWKit'
  s.homepage     = 'https://github.com/taewan0530/TWKit'
  s.license      = 'MIT'
  s.author       = { 'taewan' => 'taewan0530@daum.net' }
  s.source       = { :git => 'https://github.com/taewan0530/TWKit.git', :tag => @version }
  
  s.requires_arc = true
  s.ios.deployment_target = '8.0'

  s.subspec 'Default' do |sub|
    sub.source_files = 'Pod/**/*.{swift}'
  end

  s.subspec 'ObjectPool' do |sub|
    sub.source_files = 'Pod/utils/ObjectPool.swift'
  end

  s.subspec 'Style' do |sub|
    sub.source_files = Pod/styles/*.{swift}'
  end

  s.subspec 'Extension' do |sub|
    sub.source_files = Pod/extensions/*.{swift}'
  end

  s.default_subspec = 'Default'
end