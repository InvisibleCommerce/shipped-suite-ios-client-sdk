//
//  SSNetworking.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ShippedSuiteMode) {
    ShippedSuiteDevelopmentMode,
    ShippedSuiteProductionMode
};

/**
 `ShippedSuite` contains the base configuration the SDK needs.
 */
@interface ShippedSuite : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)allocWithZone:(struct _NSZone *)zone NS_UNAVAILABLE;

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
 Enable shield or not.
 
 @param isShieldEnabled isShieldEnabled required.
 */
+ (void)setIsShieldEnabled:(BOOL)isShieldEnabled;

/**
 Get whether shield is enabled. True as default.
 */
+ (BOOL)isShieldEnabled;

/**
 Enable green or not.
 
 @param isGreenEnabled isGreenEnabled required.
 */
+ (void)setIsGreenEnabled:(BOOL)isGreenEnabled;

/**
 Get whether green is enabled. True as default.
 */
+ (BOOL)isGreenEnabled;

/**
 Configure public key.
 */
+ (void)configurePublicKey:(NSString *)publicKey;

@end

typedef NS_ENUM(NSInteger, SSHTTPMethod) {
    SSHTTPMethodGET,
    SSHTTPMethodPOST
};

/**
 Http request
 */
@interface SSRequest : NSObject

- (NSString *)path;
- (SSHTTPMethod)method;
- (nullable NSDictionary *)parameters;
- (nullable NSData *)postData;
- (Class)responseClass;
- (NSDictionary *)headers;

@end

/**
 Http response
 */
@class SSErrorResponse;
@interface SSResponse : NSObject

+ (SSResponse *)parse:(NSData *)data;
+ (nullable SSErrorResponse *)parseError:(NSData *)data
                                    code:(NSInteger)code;

@end

/**
 An `SSErrorResponse` includes error details.
 */
@interface SSErrorResponse : SSResponse

/**
 Error message.
 */
@property (nonatomic, copy, readonly) NSString *message;

/**
 Error code.
 */
@property (nonatomic, readonly) NSInteger code;

/**
 Error object.
 */
@property (nonatomic, strong, readonly) NSError *error;

/**
 Initializer.
 
 @param message Error message.
 @param code Error code.
 @return The initialized error object.
 */
- (instancetype)initWithMessage:(NSString *)message
                           code:(NSInteger)code;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

typedef void (^SSRequestHandler)(SSResponse * _Nullable response, NSError * _Nullable error);

/**
 `SSAPIClient` is a http request client.
 */
@interface SSAPIClient : NSObject

/**
 Convenience constructor for an api client.
 
 @return The shared api client.
 */
+ (instancetype)sharedClient;

/**
 Send request.
 
 @param request A request object.
 @param handler A handler which includes response.
 */
- (void)send:(SSRequest *)request handler:(SSRequestHandler)handler;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)allocWithZone:(struct _NSZone *)zone NS_UNAVAILABLE;

@end

@protocol SSJSONDecodable <NSObject>

+ (id)decodeFromJSON:(NSDictionary *)json;

@end

@protocol SSJSONEncodable <NSObject>

- (NSDictionary *)encodeToJSON;

@end

NS_ASSUME_NONNULL_END
