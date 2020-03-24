#
#  Be sure to run `pod spec lint Rocket.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # 名称
  spec.name             = "Rocket"
  # 版本号
  spec.version          = "1.0.0"
  # 简述
  spec.summary          = "🚀Rocket is a network framework which can be easily used in iOS project"
  # 兼容的swift版本
  spec.swift_version    = '4.0'
  # 描述
  spec.description      = <<-DESC
    🚀Rocket is a network framework which can be easily used in iOS project to send HTTP request and decode to specified type. It's written in Swift and fully support JSON and Codable protocol.
                          DESC
  # 主页
  spec.homepage     = "https://github.com/tangshizhao/Rocket.git"
  # 证书
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  # 作者
  spec.author             = { "Tang Shizhao" => "tangshizhao@foxmail.com" }
  # 平台
  spec.platform     = :ios, "9.0"
  # 最低部署iOS版本
  spec.ios.deployment_target = "9.0"
  # 源码地址
  spec.source       = { :git => "https://github.com/tangshizhao/Rocket.git", :tag => "#{spec.version}" }
  # 代码文件
  spec.source_files  = "Sources", "Sources/**/*.swift"
  # 基础框架
  spec.framework  = "Foundation"
  # 三方依赖
  spec.dependency "Alamofire"
  spec.dependency "PromiseKit"
  spec.dependency "SwiftyJSON"

end
