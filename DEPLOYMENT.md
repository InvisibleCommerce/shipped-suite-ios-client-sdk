# How to deploy Shipped Suite iOS SDK

This document will take you through the process of creating/updating Shipped Suite iOS SDK pod and publishing it to the Cocoapods library.

## Requirements
### [MacOS](https://www.apple.com/mac/)
### [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12)
### [Cocoapods](http://cocoapods.org/)

## Getting started
1. Open `Terminal` app from your mac.
2. Begin a session on your current mac device.
```ruby
pod trunk register xxx@xxx.com 'ShippedSuite' --description='Integrate ShippedSuite into your iOS app.'
```
3. You must click a link in an email Trunk sends you to verify the connection between your Trunk account and the current computer. You can list your sessions by running `pod trunk me`.
4. Git clone Shipped Suite iOS SDK project and navigate to the root folder.
5. Open `ShippedSuite.podspec` and make it updated.
```ruby
Pod::Spec.new do |s|
    s.name             = 'ShippedSuite'
    s.version          = '0.1.1'
    s.summary          = 'Integrate ShippedSuite into your iOS app.'
    s.homepage         = 'https://github.com/InvisibleCommerce/shipped-suite-ios-client-sdk'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = 'Invisible Commerce'
    s.source           = { :git => 'https://github.com/InvisibleCommerce/shipped-suite-ios-client-sdk.git', :tag => s.version.to_s }
    s.platform         = :ios
    s.ios.deployment_target = '11.0'
    s.source_files     = 'ShippedSuite/Classes/**/*'
    s.resource_bundles = {
        'ShippedSuite_ShippedSuite' => ['ShippedSuite/Assets/*.xcassets']
    }
    s.public_header_files = 'ShippedSuite/Classes/**/*.h'
    s.frameworks       = 'Foundation', 'UIKit'
end
```
6. Create tag
```ruby
git tag '0.1.1'
git push --tags
```
7. Run the command in your `Terminal`.
```ruby
pod trunk push ShippedSuite.podspec --allow-warnings --verbose
```