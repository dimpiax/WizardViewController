#
# Be sure to run `pod lib lint WizardViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WizardViewController'
  s.version          = '1.1.1'
  s.summary          = 'An abstract view controller for sliding pages.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Build your tutorial / description / informative screens by trivial approach.
Setup visual assets and be flexible with page delegation.
Put special views or controls on top subview, which is not scrolling.

```swift
_wizardVC = WizardViewController()
_wizardVC.modalTransitionStyle = .coverVertical
_wizardVC.modalPresentationStyle = .overCurrentContext

// setup page indicators
_wizardVC.pageIndicatorColors = {[unowned self] currentPageIndex in
    let value: UIColor

    if let color = self._wizardVC.getView(index: currentPageIndex)?.backgroundColor {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)

        // inverse color
        value = UIColor(red: 1-r, green: 1-g, blue: 1-b, alpha: 1)
    }
    else {
        switch currentPageIndex {
            case 1: value = .darkGray
            case 2: value = .gray
            default: value = .black
        }

    }

    return (nil, value)
}

// set views
_wizardVC.setViews([B(), B(), B()])

// or

// set view controllers
_wizardVC.setViewControllers([A(), A(), A(), A()])

// set custom view on top subview
let button = UIButton(type: .custom)
button.setTitle("skip", for: .normal)
button.sizeToFit()
button.frame.origin.y = view.bounds.height - button.bounds.height - 50
button.frame.size.width = view.bounds.width
button.addTarget(self, action: #selector(closeTutorial), for: .touchUpInside)

_wizardVC.setTop(view: button)
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
