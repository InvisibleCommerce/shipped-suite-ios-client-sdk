//
//  SSWidgetView.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/8.
//

#import <UIKit/UIKit.h>
#import "ShippedSuiteConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const SSWidgetViewIsSelectedKey;
FOUNDATION_EXPORT NSString *const SSWidgetViewTotalFeeKey;
FOUNDATION_EXPORT NSString *const SSWidgetViewErrorKey;

/**
 A delegate which handles the widget callback.
 */
@class SSWidgetView;
@protocol SSWidgetViewDelegate <NSObject>

/**
 This method is called when widget state changed.
 
 @param widgetView The widget view.
 @param values A dictionary includes all of the changes.
 */
- (void)widgetView:(SSWidgetView *)widgetView onChange:(NSDictionary *)values;

@end

/**
 A widget view which shows the fee.
 */
IB_DESIGNABLE
@interface SSWidgetView : UIView

/**
 A delegate which handles the widget callback.
 */
@property (weak, nonatomic) IBOutlet id <SSWidgetViewDelegate> delegate;

/**
 Includes some basic settings.
 */
@property (strong, nonatomic) ShippedSuiteConfiguration *configuration;

/**
 This method is called to get the latest fee.
 
 @param orderValue The order value.
 */
- (void)updateOrderValue:(NSDecimalNumber *)orderValue;

@end

NS_ASSUME_NONNULL_END
