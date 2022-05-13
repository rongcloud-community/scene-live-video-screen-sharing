
Pod::Spec.new do |s|
  
  # Info
  s.name             = 'RCLiveVideoScreenShare'
  s.version          = '0.0.1'
  s.summary          = 'Scene LiveVideo ScreenShare.'
  s.description      = 'ScreenShare for RCLiveVideoLib as Extension Plugin'

  # Re
  s.homepage         = 'https://www.rongcloud.cn/devcenter?type=doc'
  s.license          = { :type => "Copyright", :text => "Copyright 2022 RongCloud" }
  s.author           = { 'shaoshuai' => 'shaoshuai@rongcloud.cn' }
  s.source           = { :git => 'https://github.com/rongcloud/rongcloud-livevideo-screen-share-ios-sdk.git', :tag => s.version.to_s }

  # Config
  s.static_framework = true
  s.ios.deployment_target = '12.0'
  s.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
      'VALID_ARCHS' => 'arm64 x86_64'
  }

  # Resource
  s.source_files = 'RCLiveVideoScreenShare/Classes/**/*'
  
  # Dependency
  # require min version >= 2.1.0.3
  s.dependency 'RCLiveVideoLib'
  
end
