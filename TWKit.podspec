@version = "0.0.8"

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

  s.subspec 'All' do |sub|
    sub.source_files = 'Pod/**/*.{swift}'
  end

  s.subspec 'Extension' do |sub|
    sub.source_files = 'Pod/extensions/*.{swift}'
  end

  s.subspec 'Function' do |sub|
    sub.source_files = 'Pod/utils/Functions.swift'
  end

  s.subspec 'ObjectPool' do |sub|
    sub.source_files = 'Pod/utils/ObjectPool.swift'
  end

  s.subspec 'StructObject' do |sub|
    sub.source_files = 'Pod/utils/StructObject.swift'
  end

  s.subspec 'EasyStyle' do |sub|
    sub.source_files = 'Pod/EasyStyle/*.{swift}'
  end

  s.subspec 'AttributedString' do |sub|
    sub.source_files = 'Pod/AttributedString/*.{swift}'
  end

  s.subspec 'GetConstraint' do |sub|
    sub.source_files = 'Pod/GetConstraint/*.{swift}'
  end

  s.subspec 'KeyboardHelper' do |sub|
    sub.source_files = 'Pod/KeyboardHelper/*.{swift}'
  end

  s.default_subspec = 'All'
end