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
    NSNumber *orderValue = json[@"order_value"];
    offers.orderValue = [NSDecimalNumber decimalNumberWithDecimal:orderValue.decimalValue];
    NSNumber *shieldFee = json[@"shield_fee"];
    offers.shieldFee = [NSDecimalNumber decimalNumberWithDecimal:shieldFee.decimalValue];
    NSNumber *greenFee = json[@"green_fee"];
    offers.greenFee = [NSDecimalNumber decimalNumberWithDecimal:greenFee.decimalValue];
    NSString *offeredAt = json[@"offered_at"];
    offers.offeredAt = [NSDate dateFromString:offeredAt];
    return offers;
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
