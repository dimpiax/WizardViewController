# WizardViewController

[![Language](https://img.shields.io/badge/swift-3.0-fec42e.svg)](https://swift.org/blog/swift-3-0-released/)
[![Version](https://img.shields.io/cocoapods/v/WizardViewController.svg?style=flat)](http://cocoapods.org/pods/WizardViewController)
[![License](https://img.shields.io/cocoapods/l/WizardViewController.svg?style=flat)](http://cocoapods.org/pods/WizardViewController)
[![Platform](https://img.shields.io/cocoapods/p/WizardViewController.svg?style=flat)](http://cocoapods.org/pods/WizardViewController)

## Description
Build your tutorial / description / informative screens by trivial approach.
Setup visual assets and be flexible with page delegation.
Put special views or controls on top subview, which is not scrolling.

## Example

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

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

WizardViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "WizardViewController"
```

## Author

Pilipenko Dima, dimpiax@gmail.com

## License

WizardViewController is available under the MIT license. See the LICENSE file for more info.
