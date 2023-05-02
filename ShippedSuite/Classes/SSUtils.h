//
//  SSUtils.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ShippedSuiteConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Utils)

+ (BOOL)isIpad;

@end

@interface UIColor (Utils)

+ (UIColor *)colorWithHex:(NSUInteger)hex;

+ (UIColor *)widgetViewBackgroundColorFor:(ShippedSuiteAppearance)appearance;

+ (UIColor *)titleColorFor:(ShippedSuiteAppearance)appearance;

+ (UIColor *)learnMoreColorFor:(ShippedSuiteAppearance)appearance;

+ (UIColor *)feeColorFor:(ShippedSuiteAppearance)appearance;

+ (UIColor *)descColorFor:(ShippedSuiteAppearance)appearance;

+ (UIColor *)modalBackgroundColorFor:(ShippedSuiteAppearance)appearance;

+ (UIColor *)modalHeaderColorFor:(ShippedSuiteAppearance)appearance;

+ (UIColor *)modalTitleColorFor:(ShippedSuiteAppearance)appearance;

+ (UIColor *)modalSubtitleColorFor:(ShippedSuiteAppearance)appearance;

+ (UIColor *)modalActionViewColorFor:(ShippedSuiteAppearance)appearance type:(ShippedSuiteType)type;

+ (UIColor *)modalActionTextColorFor:(ShippedSuiteAppearance)appearance;

+ (UIColor *)modalActionLineColorFor:(ShippedSuiteAppearance)appearance;

+ (UIColor *)modalActionLinkColorFor:(ShippedSuiteAppearance)appearance;

+ (UIColor *)modalCTABackgroundColorFor:(ShippedSuiteAppearance)appearance;

+ (UIColor *)modalCTATextColorFor:(ShippedSuiteAppearance)appearance;

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
