//
//  ShippedSuite+Configuration.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2023/2/28.
//

#import "SSNetworking.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ShippedSuiteModeDevelopment,
    ShippedSuiteModeProduction
} ShippedSuiteMode;

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

@end

NS_ASSUME_NONNULL_END
