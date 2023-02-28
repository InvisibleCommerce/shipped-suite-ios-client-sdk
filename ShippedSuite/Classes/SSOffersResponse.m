//
//  SSOffersResponse.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSOffersResponse.h"
#import "SSUtils.h"

@implementation SSCurrency

+ (id)decodeFromJSON:(NSDictionary *)json
{
    SSCurrency *currency = [SSCurrency new];
    currency.decimalMark = json[@"decimal_mark"];
    currency.symbol = json[@"symbol"];
    NSNumber *symbolFirst = json[@"symbol_first"];
    if (symbolFirst) {
        currency.symbolFirst = [symbolFirst boolValue];
    }
    currency.thousandsSeparator = json[@"thousands_separator"];
    NSNumber *subunitToUnit = json[@"subunit_to_unit"];
    if (subunitToUnit && [subunitToUnit isKindOfClass:[NSNumber class]]) {
        currency.subunitToUnit = [NSDecimalNumber decimalNumberWithDecimal:[subunitToUnit decimalValue]];
    }
    currency.isoCode = json[@"iso_code"];
    currency.name = json[@"name"];
    return currency;
}

@end

@implementation SSFeeWithCurrency

+ (id)decodeFromJSON:(NSDictionary *)json
{
    SSFeeWithCurrency *feeWithCurrency = [SSFeeWithCurrency new];
    NSDictionary *currencyJson = json[@"currency"];
    if (currencyJson && [currencyJson isKindOfClass:[NSDictionary class]]) {
        feeWithCurrency.currency = [SSCurrency decodeFromJSON:currencyJson];
    }
    NSNumber *subunits = json[@"subunits"];
    if (subunits && [subunits isKindOfClass:[NSNumber class]]) {
        feeWithCurrency.subunits = [NSDecimalNumber decimalNumberWithDecimal:[subunits decimalValue]];
    }
    feeWithCurrency.formatted = json[@"formatted"];
    return feeWithCurrency;
}

@end

@implementation SSOffers

+ (id)decodeFromJSON:(NSDictionary *)json
{
    SSOffers *offers = [SSOffers new];
    offers.storefrontId = json[@"storefront_id"];
    NSString *orderValue = json[@"order_value"];
    if (orderValue && [orderValue isKindOfClass:[NSString class]]) {
        offers.orderValue = [NSDecimalNumber decimalNumberWithString:orderValue];
    }
    NSString *shieldFee = json[@"shield_fee"];
    if (shieldFee && [shieldFee isKindOfClass:[NSString class]]) {
        offers.shieldFee = [NSDecimalNumber decimalNumberWithString:shieldFee];
    }
    NSDictionary *shieldFeeWithCurrency = json[@"shield_fee_with_currency"];
    if (shieldFeeWithCurrency && [shieldFeeWithCurrency isKindOfClass:[NSDictionary class]]) {
        offers.shieldFeeWithCurrency = [SSFeeWithCurrency decodeFromJSON:shieldFeeWithCurrency];
    }
    NSString *greenFee = json[@"green_fee"];
    if (greenFee && [greenFee isKindOfClass:[NSString class]]) {
        offers.greenFee = [NSDecimalNumber decimalNumberWithString:greenFee];
    }
    NSDictionary *greenFeeWithCurrency = json[@"green_fee_with_currency"];
    if (greenFeeWithCurrency && [greenFeeWithCurrency isKindOfClass:[NSDictionary class]]) {
        offers.greenFeeWithCurrency = [SSFeeWithCurrency decodeFromJSON:greenFeeWithCurrency];
    }
    NSNumber *mandatory = json[@"mandatory"];
    if (mandatory) {
        offers.isMandatory = [mandatory boolValue];
    }
    NSString *offeredAt = json[@"offered_at"];
    if (offeredAt && [offeredAt isKindOfClass:[NSString class]]) {
        offers.offeredAt = [NSDate dateFromString:offeredAt];
    }
    return offers;
}

- (BOOL)isShieldAvailable
{
    return self.shieldFee != nil;
}

- (BOOL)isGreenAvailable
{
    return self.greenFee != nil;
}

@end

@interface SSOffersResponse ()

@property (nonatomic, strong, readwrite) SSOffers *offers;

@end

@implementation SSOffersResponse

+ (SSOffersResponse *)parse:(NSData *)data
{
    NSError *error = nil;
    id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    SSOffersResponse *response = [SSOffersResponse new];
    response.offers = [SSOffers decodeFromJSON:responseObject];
    return response;
}

@end
