#
# Be sure to run `pod lib lint HintPod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HintPod'
  s.version          = '1.0.5'
  s.summary          = 'Build a community with two lines of code.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/melwaraki/HintPod'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'melwaraki' => 'mirage299@gmail.com' }
  s.source           = { :git => 'https://github.com/melwaraki/HintPod.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hintpod'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'HintPod/Classes/**/*'
  s.resources = "HintPod/Assets/*.{png,jpeg,jpg,storyboard,xib,xcassets,json}"
  
   s.resource_bundles = {
     'HintPod' => ['HintPod/Assets/*.png']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'UITextView+Placeholder', '~> 1.4.0'
end
