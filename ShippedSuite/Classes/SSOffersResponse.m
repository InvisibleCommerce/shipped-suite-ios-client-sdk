//
//  SSOffersResponse.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSOffersResponse.h"
#import "SSUtils.h"

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
    NSString *greenFee = json[@"green_fee"];
    if (greenFee && [greenFee isKindOfClass:[NSString class]]) {
        offers.greenFee = [NSDecimalNumber decimalNumberWithString:greenFee];
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
