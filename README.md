# WizardViewController

[![Language](https://img.shields.io/badge/swift-3.0-fec42e.svg)](https://swift.org/blog/swift-3-0-released/)
[![Version](https://img.shields.io/cocoapods/v/WizardViewController.svg?style=flat)](http://cocoapods.org/pods/WizardViewController)
[![License](https://img.shields.io/cocoapods/l/WizardViewController.svg?style=flat)](http://cocoapods.org/pods/WizardViewController)
[![Platform](https://img.shields.io/cocoapods/p/WizardViewController.svg?style=flat)](http://cocoapods.org/pods/WizardViewController)

## Description
Build your tutorial / description / informative screens by trivial approach.
Setup visual assets and be flexible with page delegation.

## Example

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

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
Swift 3

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
