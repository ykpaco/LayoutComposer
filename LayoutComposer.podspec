#
# Be sure to run `pod lib lint LayoutComposer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "LayoutComposer"
  s.version          = "0.1.0"
  s.summary          = "LayoutComposer provides simple and intuitive methods to write the typical UIView layout patterns in swift code."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
LayoutComposer provides methods to write the typical UIView layout patterns such as:

* place UIViews along the vertical/horizontal axis. (VBox/HBox Layout)
* place child UIViews at the top|bottom|left|right|center of the parent UIView. (Relative Layout)
* make a child UIView fit the size of its parent view. (Fit Layout)

Since each layout pattern is able to contain other layout patterns as child components, you can form complicated layouts.
Auto Layout code written by LayoutComposer expresses the UIView hierarchy.
It makes Auto Layout code very simple and intuitive.
                       DESC

  s.homepage         = "https://github.com/ykpaco/LayoutComposer"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Yusuke Kawakami" => "kawakami.paco.yusuke@gmail.com" }
  s.source           = { :git => "https://github.com/ykpaco/LayoutComposer.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'LayoutComposer' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
