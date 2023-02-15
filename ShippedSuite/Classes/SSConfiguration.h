//
//  SSConfiguration.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2023/2/15.
//

#import <Foundation/Foundation.h>
#import "SSNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSConfiguration : NSObject

/**
 Support green | shield offers. Default is ShippedSuiteTypeShield.
 */
@property (nonatomic) ShippedSuiteType type;

/**
 False is default.
 When it’s false it means that the widget will show the fee label.
 When it’s true it means that the widget will hide the fee label.
 */
@property (nonatomic) BOOL isInformational;

@end

@interface SSWidgetViewConfiguration : SSConfiguration

/**
 False is default.
 When it’s false it means that the widget will respect the config that comes from the server.
 When it’s true it means that the widget will hide the widget toggle and ignore the config that comes from the server.
 */
@property (nonatomic) BOOL isMandatory;

/**
 False is default.
 When it’s false it means that the widget will have to show green/shield/green+shield variants based on client configuration.
 When it's true, it means that the widget will ignore client config, and only respects the config that comes from the server.
 */
@property (nonatomic) BOOL isRespectServer;

@end

NS_ASSUME_NONNULL_END
