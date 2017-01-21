Pod::Spec.new do |s|
  s.name         = "GKMessageTool"
  s.version      = "1.0.0"
  s.summary      = "基于MBProgressHUD 1.0.0 的封装工具类GKMessageTool."
  s.homepage     = "http://github.com/QuintGao/GKMessageTool"
  s.license      = "MIT"
  s.authors            = { "高坤" => "1094887059@qq.com" }
  s.social_media_url   = "http://github.com/QuintGao"
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "http://github.com/QuintGao/GKMessageTool.git", :tag => s.version.to_s }
  
  s.requires_arc  = true
  s.source_files  = "GKMessageTool/**/*.{h,m}"
  s.public_header_files = "GKMessageTool/**/*.{h}"
  s.resource      = 'GKMessageTool/GKMessageTool.bundle' 
  s.frameworks    = "Foundation", "UIKit"

  s.dependency "MBProgressHUD"

end
