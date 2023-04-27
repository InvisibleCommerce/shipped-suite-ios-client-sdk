//
//  SSUtils.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/8.
//

#import "SSUtils.h"

@implementation UIDevice (Utils)

+ (BOOL)isIpad
{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

@end

@implementation UIColor (Utils)

+ (UIColor *)colorWithHex:(NSUInteger)hex
{
    CGFloat red, green, blue, alpha;
    red = ((CGFloat)((hex >> 16) & 0xFF)) / ((CGFloat)0xFF);
    green = ((CGFloat)((hex >> 8) & 0xFF)) / ((CGFloat)0xFF);
    blue = ((CGFloat)((hex >> 0) & 0xFF)) / ((CGFloat)0xFF);
    alpha = hex > 0xFFFFFF ? ((CGFloat)((hex >> 24) & 0xFF)) / ((CGFloat)0xFF) : 1;
    return [UIColor colorWithRed: red green:green blue:blue alpha:alpha];
}

+ (UIColor *)widgetViewBackgroundColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0x292929];
        }
    }
    return [UIColor whiteColor];
}

+ (UIColor *)titleColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0xE6E6E6];
        }
    }
    return [UIColor colorWithHex:0x1A1A1A];
}

+ (UIColor *)learnMoreColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0xB2B2B2];
        }
    }
    return [UIColor colorWithHex:0x4D4D4D];
}

+ (UIColor *)feeColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0xE6E6E6];
        }
    }
    return [UIColor colorWithHex:0x1A1A1A];
}

+ (UIColor *)descColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0xCCCCCC];
        }
    }
    return [UIColor colorWithHex:0x4D4D4D];
}

+ (UIColor *)modalBackgroundColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0x1C1C1E];
        }
    }
    return [UIColor whiteColor];
}

+ (UIColor *)modalHeaderColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0x000000];
        }
    }
    return [UIColor colorWithHex:0x000000];
}

+ (UIColor *)modalTitleColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0xFFFFFF];
        }
    }
    return [UIColor colorWithHex:0x000000];
}

+ (UIColor *)modalSubtitleColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0xFFFFFF];
        }
    }
    return [UIColor colorWithHex:0x000000];
}

+ (UIColor *)modalActionViewColorFor:(ShippedSuiteAppearance)appearance type:(ShippedSuiteType)type
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0x19ffffff];
        }
    }
    return type == ShippedSuiteTypeShield ? [UIColor colorWithHex:0x13747480] : [UIColor colorWithHex:0xFFFFFF];
}

+ (UIColor *)modalActionTextColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0x7fffffff];
        }
    }
    return [UIColor colorWithHex:0x993c3c43];
}

+ (UIColor *)modalActionLineColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0xC1C1C1];
        }
    }
    return [UIColor colorWithHex:0xC1C1C1];
}

+ (UIColor *)modalActionLinkColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0x888888];
        }
    }
    return [UIColor colorWithHex:0x888888];
}

+ (UIColor *)modalCTABackgroundColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0xFFCF4D];
        }
    }
    return [UIColor colorWithHex:0xFFC933];
}

+ (UIColor *)modalCTATextColorFor:(ShippedSuiteAppearance)appearance
{
    if (@available(iOS 13.0, *)) {
        if ((UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && appearance == ShippedSuiteAppearanceAuto) || appearance == ShippedSuiteAppearanceDark) {
            return [UIColor colorWithHex:0x000000];
        }
    }
    return [UIColor colorWithHex:0x000000];
}

@end

@implementation NSDictionary (Utils)

- (NSString *)queryURLEncoding
{
    NSMutableArray<NSString *> *parametersArray = [NSMutableArray array];
    [self enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *queryString = [[NSString stringWithFormat:@"%@", obj] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [parametersArray addObject:[NSString stringWithFormat:@"%@=%@", key, queryString]];
    }];
    return [parametersArray componentsJoinedByString:@"&"];
}

@end

@implementation NSDate (Utils)

+ (NSDate *)dateFromString:(NSString *)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSX"];
    return [dateFormatter dateFromString:string];
}

@end

@implementation UIWindow (Utils)

+ (UIEdgeInsets)safeAreaInsets
{
    UIWindow *window = UIApplication.sharedApplication.windows.firstObject;
    return window.safeAreaInsets;
}

@end

@implementation NSDecimalNumber (Utils)

- (NSString *)currencyStringWithSymbol:(NSString *)symbol
                                  code:(NSString *)code
                                 space:(NSString *)space
                      decimalSeparator:(NSString *)decimalSeparator
                 usesGroupingSeparator:(BOOL)usesGroupingSeparator
                     groupingSeparator:(NSString *)groupingSeparator
                        fractionDigits:(NSUInteger)fractionDigits
                           symbolFirst:(BOOL)symbolFirst
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.currencySymbol = symbol;
    formatter.currencyCode = code;
    formatter.currencyDecimalSeparator = decimalSeparator;
    formatter.usesGroupingSeparator = usesGroupingSeparator;
    formatter.currencyGroupingSeparator = groupingSeparator;
    formatter.minimumFractionDigits = fractionDigits;
    formatter.maximumFractionDigits = fractionDigits;
    
    if (symbolFirst) {
        formatter.positivePrefix = [NSString stringWithFormat:@"%@%@", symbol, space];
        formatter.positiveSuffix = @"";
        formatter.negativePrefix = [NSString stringWithFormat:@"%@%@-", symbol, space];
        formatter.negativeSuffix = @"";
    } else {
        formatter.positivePrefix = @"";
        formatter.positiveSuffix = [NSString stringWithFormat:@"%@%@", space, symbol];
        formatter.negativePrefix = @"-";
        formatter.negativeSuffix = [NSString stringWithFormat:@"%@%@", space, symbol];
    }
    NSString *formattedString = [formatter stringFromNumber:self];
    return [NSString stringWithFormat:@"\u202A%@\u202C", formattedString];
}

@end
