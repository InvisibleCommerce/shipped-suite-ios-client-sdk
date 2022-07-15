# ShippedSuite iOS SDK

 [![Platform](https://img.shields.io/cocoapods/p/ShippedSuite.svg?style=flat)](https://cocoapods.org/pods/ShippedSuite)
 [![Version](https://img.shields.io/cocoapods/v/ShippedSuite.svg?style=flat)](https://cocoapods.org/pods/ShippedSuite)
 [![License](https://img.shields.io/cocoapods/l/ShippedSuite.svg?style=flat)](https://cocoapods.org/pods/ShippedSuite)
 [![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-green.svg?style=flat)](https://cocoapods.org)
 [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-green.svg?style=flat)](https://github.com/Carthage/Carthage)
 [![SPM compatible](https://img.shields.io/badge/SPM-compatible-green.svg?style=flat)](https://www.swift.org/package-manager)
 [![codecov](https://codecov.io/gh/InvisibleCommerce/shipped-shield-ios-sdk/branch/main/graph/badge.svg?token=DUeMBvpJjO)](https://codecov.io/gh/InvisibleCommerce/shipped-shield-ios-sdk)

Shipped Shield offers premium package assurance for shipments that are lost, damaged or stolen. Instantly track and resolve shipment issues hassle-free with the app.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

The ShippedSuite iOS SDK requires Xcode 13.3.1 or later and is compatible with apps targeting iOS 11.0 or above.

## Installation

The ShippedSuite iOS SDK is available through [CocoaPods](https://cocoapods.org/), [Carthage](https://github.com/Carthage/Carthage), [SPM](https://www.swift.org/package-manager).

### CocoaPods

If you haven't already, install the latest version of [CocoaPods](https://cocoapods.org/).
If you don't have an existing `Podfile`, run the following command to create one:
```ruby
pod init
```
Add this line to your Podfile:
```ruby
pod 'ShippedSuite'
```
Run the following command
```ruby
pod install
```
Don’t forget to use the `.xcworkspace` file to open your project in Xcode, instead of the `.xcodeproj` file, from here on out.
In the future, to update to the latest version of the SDK, just run:
```ruby
pod update ShippedSuite
```

### Carthage

If you haven't already, install the latest version of [Carthage](https://github.com/Carthage/Carthage).
To use it, you need create a `Cartfile` and add this line to your Cartfile:
```ogdl
github "InvisibleCommerce/shipped-shield-ios-sdk"
```
Run the following command
```ruby
carthage update --use-xcframeworks
```
Drag the built `.xcframework` bundles from `Carthage/Build` into the "Frameworks and Libraries" section of your application’s Xcode project.

### Swift Package Manager

[Add package dependency from xcode](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).

## Setup

Import SDK.

```objective-c
#import <ShippedSuite/ShippedSuite.h>
```

Configure the SDK with your ShippedSuite publishable API key.

```objective-c
[ShippedSuite configurePublicKey:@"Public key"];
```

If you want to test on different endpoint, you can customize mode. The default is Development mode, so make sure to switch to Production mode for your production build. 

```objective-c
[ShippedSuite setMode:ShippedSuiteProductionMode];
```

### Create a Shield Widget view

You can initialize it with a default value, then put it where you want, and it will request shipped fee automatically.

```objective-c
SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectMake(x, y, width, height)];
widgetView.delegate = self;
```

Or you can use it in storyboards.

Whenever the cart value changes, update the widget view with the latest cart value. This value should be the sum of the value of the order items, prior to discounts, shipping, taxes, etc. 

```objective-c
[widgetView updateOrderValue:cartValueRoundedNumber];
```

To get the callback from widget, you need implement the `SSWidgetViewDelegate` delegate.

```objective-c
#pragma mark - SSWidgetViewDelegate

- (void)widgetView:(SSWidgetView *)widgetView onChange:(NSDictionary *)values
{
    BOOL isShieldEnabled = [values[SSWidgetViewIsShieldEnabledKey] boolValue];
    NSLog(@"Shield Fee: %@", isShieldEnabled ? @"YES" : @"NO");
    
    NSDecimalNumber *fee = values[SSWidgetViewShieldFeeKey];
    if (fee) {
        NSLog(@"Shield Fee: %@", fee.stringValue);
    }
    
    NSError *error = values[SSWidgetViewErrorKey];
    if (error) {
        NSLog(@"Widget error: %@", error.localizedDescription);
    }
}
```

```
Shield Fee: NO
Shield Fee: 2.27
```

Within the callback, implement any logic necessary to add or remove Shield from the cart, based on whether `isShieldEnabled` is true or false. 

### Customization

If you plan to implement the widget yourself to fit the app style, you can still use the functionality provided by the SDK.

- Send the Shield Fee request

```objective-c
[ShippedSuite getShieldFee:[[NSDecimalNumber alloc] initWithString:_textField.text] completion:^(SSShieldOffer * _Nullable offer, NSError * _Nullable error) {
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return;
    }

    NSLog(@"Get shield fee: %@", offer.shieldFee.stringValue);
}];
```

- Display learn more modal

```objective-c
SSLearnMoreViewController *controller = [[SSLearnMoreViewController alloc] initWithNibName:nil bundle:nil];
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    nav.preferredContentSize = CGSizeMake(650, 600);
}
[self presentViewController:nav animated:YES completion:nil];
```

## License

ShippedSuite is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
