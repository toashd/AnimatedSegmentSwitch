# AnimatedSegmentSwitch
AnimatedSegmentSwitch is a configurable multi-segment switch control written in Swift.

[![](http://img.shields.io/badge/iOS-9.0%2B-blue.svg)]()
[![](http://img.shields.io/badge/Swift-2.0-blue.svg)]()
[![CI Status](http://img.shields.io/travis/Tobias Schmid/AnimatedSegmentSwitch.svg?style=flat)](https://travis-ci.org/Tobias Schmid/AnimatedSegmentSwitch)
[![Version](https://img.shields.io/cocoapods/v/AnimatedSegmentSwitch.svg?style=flat)](http://cocoapods.org/pods/AnimatedSegmentSwitch)
[![License](https://img.shields.io/cocoapods/l/AnimatedSegmentSwitch.svg?style=flat)](http://cocoapods.org/pods/AnimatedSegmentSwitch)
[![Platform](https://img.shields.io/cocoapods/p/AnimatedSegmentSwitch.svg?style=flat)](http://cocoapods.org/pods/AnimatedSegmentSwitch)


![](https://github.com/toashd/AnimatedSegmentSwitch/blob/master/demo.png)
![](https://github.com/toashd/AnimatedSegmentSwitch/blob/master/demo.gif)

## Features
* Up-to-date: Swift 2 (Xcode 7)
* Support for Interface Builder
* Supports multi-segments
* Easy to use, lightweight, customizable and configurable
* Works as UISegmentedControl and UISwitch drop-in replacement

## Usage

```swift
import AnimatedSegmentSwitch

let segmentedSwitch = AnimatedSegmentSwitch()
segmentedSwitch.items = ["Swift", "Objective-C", "Other"]
segmentedSwitch.titleColor = .whiteColor()
segmentedSwitch.selectedTitleColor = .blueColor()
segmentedSwitch.font = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
segmentedSwitch.backgroundColor = .blueColor()
segmentedSwitch.thumbColor = .whiteColor()
segmentedSwitch.thumbCornerRadius = 1.0
segmentedSwitch.thumbInset = 0.0
segmentedSwitch.addTarget(self, action: "segmentSwitchValueDidChange:", forControlEvents: .ValueChanged)

view.addSubview(segmentedSwitch)
```

Alternatively the control's API can be easily configured via Interface Builder.
For more code, open and run the sample project in Xcode.

## Requirements
* Xcode 7
* Swift 2.0
* iOS 8.0 or higher
* ARC

## Installation

AnimatedSegmentSwitch is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AnimatedSegmentSwitch"
```

You can also just drop AnimatedSegmentSwitch.swift into your project and start
coding.

## Contribution
Please feel free to suggest any kind of improvements, refactorings, or just file an
issue, fork and submit a pull request.

## Get in touch

Tobias Schmid, toashd@gmail.com, [@toashd](http://twitter.com/toashd), [toashd.com](http://toashd.com)

## License

AnimatedSegmentSwitch is available under the MIT license. See the LICENSE file for more info.

