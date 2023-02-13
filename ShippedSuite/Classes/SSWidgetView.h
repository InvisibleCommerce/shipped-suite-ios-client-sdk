//
//  SSWidgetView.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/8.
//

#import <UIKit/UIKit.h>
#import "SSNetworking.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const SSWidgetViewIsSelectedKey;
FOUNDATION_EXPORT NSString *const SSWidgetViewShieldFeeKey;
FOUNDATION_EXPORT NSString *const SSWidgetViewGreenFeeKey;
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
 Support green | shield offers. Default is ShippedSuiteTypeShield.
 */
@property (nonatomic) ShippedSuiteType type;

/**
 False is default.
 When it’s false it means that the widget will respect the config that comes from the server.
 When it’s true it means that the widget will hide the widget toggle and ignore the config that comes from the server.
 */
@property (nonatomic) BOOL isMandatory;

/**
 False is default.
 When it’s false it means that the widget will show the fee label.
 When it’s true it means that the widget will hide the fee label.
 */
@property (nonatomic) BOOL isInformational;

/**
 False is default.
 When it’s false it means that the widget will have to show green/shield/green+shield variants based on client configuration.
 When it's true, it means that the widget will ignore client config, and only respects the config that comes from the server.
 */
@property (nonatomic) BOOL isRespectServer;

/**
 A delegate which handles the widget callback.
 */
@property (weak, nonatomic) IBOutlet id <SSWidgetViewDelegate> delegate;

/**
 This method is called to get the latest fee.
 
 @param orderValue The order value.
 */
- (void)updateOrderValue:(NSDecimalNumber *)orderValue;

@end

NS_ASSUME_NONNULL_END
