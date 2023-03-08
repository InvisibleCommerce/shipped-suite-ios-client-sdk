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
