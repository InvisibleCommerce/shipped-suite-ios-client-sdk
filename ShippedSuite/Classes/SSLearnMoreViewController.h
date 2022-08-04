//
//  SSLearnMoreViewController.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/8.
//

#import <UIKit/UIKit.h>
#import "SSWidgetView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `SSLearnMoreViewController` is a view controller to show the learn more page.
 */
@interface SSLearnMoreViewController : UIViewController

- (instancetype)initWithOffers:(SSWidgetViewOffers)offers;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
