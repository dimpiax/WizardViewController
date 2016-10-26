#
# Be sure to run `pod lib lint WizardViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WizardViewController'
  s.version          = '1.0.0'
  s.summary          = 'An abstract view controller for sliding pages.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Build your tutorial / description / informative screens by trivial approach.
Setup visual assets and be flexible with page delegation.

```swift
let wizardVC = WizardViewController()

// setup page indicators
wizardVC.pageIndicatorColors = { currentPageIndex in
let value: UIColor
switch currentPageIndex {
case 1: value = .darkGray
case 2: value = .gray
default: value = .black
}

return (nil, value)
}

// set view controllers
wizardVC.setViewControllers([A(), A(), A(), A()])
// or
// set views
wizardVC.setViews([B(), B(), B()])

addChildViewController(_wizardVC)
_wizardVC.didMove(toParentViewController: self)
view.addSubview(_wizardVC.view)
```
                       DESC

  s.homepage         = 'https://github.com/dimpiax/WizardViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pilipenko Dima' => 'dimpiax@gmail.com' }
  s.source           = { :git => 'https://github.com/dimpiax/WizardViewController.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dimpiax'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WizardViewController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WizardViewController' => ['WizardViewController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
