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

@interface NSDecimalNumber (Utils)

- (NSString *)currencyStringWithSymbol:(NSString *)symbol
                                  code:(NSString *)code
                                 space:(NSString *)space
                      decimalSeparator:(NSString *)decimalSeparator
                 usesGroupingSeparator:(BOOL)usesGroupingSeparator
                     groupingSeparator:(NSString *)groupingSeparator
                        fractionDigits:(NSUInteger)fractionDigits
                           symbolFirst:(BOOL)symbolFirst;

@end

NS_ASSUME_NONNULL_END
