//
//  SSUtils.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Utils)

+ (BOOL)isIpad;

@end

@interface UIColor (Utils)

+ (UIColor *)colorWithHex:(NSUInteger)hex;

@end

@interface NSDictionary (Utils)

- (NSString *)queryURLEncoding;

@end

@interface NSDate (Utils)

+ (NSDate *)dateFromString:(NSString *)string;

@end

@interface UIWindow (Utils)

+ (UIEdgeInsets)safeAreaInsets;

@end

NS_ASSUME_NONNULL_END
