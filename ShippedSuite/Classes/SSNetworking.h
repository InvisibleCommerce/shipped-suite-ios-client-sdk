//
//  SSNetworking.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SSHTTPMethod) {
    SSHTTPMethodGET,
    SSHTTPMethodPOST
};

/**
 `ShippedSuite` contains the base configuration the SDK needs.
 */
@interface ShippedSuite : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)allocWithZone:(struct _NSZone *)zone NS_UNAVAILABLE;

@end

/**
 Http request
 */
@interface SSHTTPRequest : NSObject

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
@interface SSHTTPResponse : NSObject

+ (SSHTTPResponse *)parse:(NSData *)data;
+ (nullable SSErrorResponse *)parseError:(NSData *)data
                                    code:(NSInteger)code;

@end

/**
 An `SSErrorResponse` includes error details.
 */
@interface SSErrorResponse : SSHTTPResponse

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

typedef void (^SSHTTPRequestHandler)(SSHTTPResponse * _Nullable response, NSError * _Nullable error);

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
- (void)send:(SSHTTPRequest *)request handler:(SSHTTPRequestHandler)handler;

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
