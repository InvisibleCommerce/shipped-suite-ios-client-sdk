//
//  ShippedSuite+Configuration.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2023/2/28.
//

#import "ShippedSuite.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ShippedSuiteModeDevelopment,
    ShippedSuiteModeProduction
} ShippedSuiteMode;

typedef enum : NSUInteger {
    ShippedSuiteTypeShield,
    ShippedSuiteTypeGreen,
    ShippedSuiteTypeGreenAndShield
} ShippedSuiteType;

@interface ShippedSuite (Configuration)

/**
 Set base URL.
 
 @param baseURL A baseURL required.
 */
+ (void)setDefaultBaseURL:(NSURL *)baseURL;

/**
 Get base URL.
 */
+ (NSURL *)defaultBaseURL;

/**
 Set sdk mode.
 
 @param mode A mode required.
 */
+ (void)setMode:(ShippedSuiteMode)mode;

/**
 Get sdk mode. Development mode as default.
 */
+ (ShippedSuiteMode)mode;

/**
 Configure public key.
 */
+ (void)configurePublicKey:(NSString *)publicKey;

/**
 Public key.
 */
+ (NSString *)publicKey;

/**
 Set shipped suite type.
 
 @param type A type required.
 */
+ (void)setType:(ShippedSuiteType)type;

/**
 Support green | shield offers. Default is ShippedSuiteTypeShield.
 */
+ (ShippedSuiteType)type;

/**
 Set isInformational.
 
 @param isInformational A boolean required.
 */
+ (void)setIsInformational:(BOOL)isInformational;

/**
 False is default.
 When it’s false it means that the widget will show the fee label.
 When it’s true it means that the widget will hide the fee label.
 */
+ (BOOL)isInformational;

/**
 Set isMandatory.
 
 @param isMandatory A boolean required.
 */
+ (void)setIsMandatory:(BOOL)isMandatory;

/**
 False is default.
 When it’s false it means that the widget will respect the config that comes from the server.
 When it’s true it means that the widget will hide the widget toggle and ignore the config that comes from the server.
 */
+ (BOOL)isMandatory;

/**
 Set isRespectServer.
 
 @param isRespectServer A boolean required.
 */
+ (void)setIsRespectServer:(BOOL)isRespectServer;

/**
 False is default.
 When it’s false it means that the widget will have to show green/shield/green+shield variants based on client configuration.
 When it's true, it means that the widget will ignore client config, and only respects the config that comes from the server.
 */
+ (BOOL)isRespectServer;

@end

NS_ASSUME_NONNULL_END
