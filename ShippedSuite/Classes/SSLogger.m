//
//  SSLogger.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSLogger.h"

@implementation SSLogger

+ (instancetype)sharedLogger
{
    static SSLogger *sharedLogger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLogger = [self new];
    });
    return sharedLogger;
}

- (void)logException:(NSString *)message
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:message
                                 userInfo:nil];
}

- (void)logEvent:(NSString *)name
{
    [self logEvent:name parameters:@{}];
}

- (void)logEvent:(NSString *)name parameters:(NSDictionary *)parameters
{
    if (self.enableLogPrinted) {
        NSLog(@"[%@]:\n%@", name, parameters.description);
    }
}

@end
