#
# Be sure to run `pod lib lint CleanSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CleanSDK'
  s.version          = '0.1.25'
  s.summary          = 'A short description of CleanSDK.'
  s.module_name      = 'CleanSDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://bitbucket.org/purenative/clean.sdk.ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Artem Eremeev' => 'jeremy1002@yandex.ru' }
  s.source           = { :git => 'https://github.com/Artem Eremeev/CleanSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.requires_arc     = true
  s.ios.deployment_target = '10.0'
  s.swift_version    = '5.0'

  s.source_files = 'CleanSDK/Classes/**/**/*.{swift}', 'CleanSDK/Classes/**/*.{swift}'
  

  
  # s.resource_bundles = {
  #   'CleanSDK' => ['CleanSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
#   s.dependency 'AFNetworking', '~> 2.3'
   s.dependency 'RxSwift'
   s.dependency 'RxCocoa'
   s.dependency 'Alamofire', '< 5'
   s.dependency 'RxDataSources'
end
