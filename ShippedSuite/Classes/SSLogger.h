//
//  SSLogger.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSLogger : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)allocWithZone:(struct _NSZone *)zone NS_UNAVAILABLE;

@property (nonatomic) BOOL enableLogPrinted;
@property (class, nonatomic, readonly, strong) SSLogger *sharedLogger;

- (void)logException:(NSString *)message;
- (void)logEvent:(NSString *)name;
- (void)logEvent:(NSString *)name parameters:(NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
