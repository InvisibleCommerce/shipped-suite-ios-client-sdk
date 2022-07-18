//
//  SSShieldResponse.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSShieldResponse.h"
#import "SSUtils.h"

@implementation SSShieldOffer

+ (id)decodeFromJSON:(NSDictionary *)json
{
    SSShieldOffer *shieldOffer = [SSShieldOffer new];
    shieldOffer.storefrontId = json[@"storefront_id"];
    NSNumber *orderValue = json[@"order_value"];
    shieldOffer.orderValue = [NSDecimalNumber decimalNumberWithDecimal:orderValue.decimalValue];
    NSNumber *shieldFee = json[@"shield_fee"];
    shieldOffer.shieldFee = [NSDecimalNumber decimalNumberWithDecimal:shieldFee.decimalValue];
    NSNumber *greenFee = json[@"green_fee"];
    shieldOffer.greenFee = [NSDecimalNumber decimalNumberWithDecimal:greenFee.decimalValue];
    NSString *offeredAt = json[@"offered_at"];
    shieldOffer.offeredAt = [NSDate dateFromString:offeredAt];
    return shieldOffer;
}

@end

@interface SSShieldResponse ()

@property (nonatomic, strong, readwrite) SSShieldOffer *shieldOffer;

@end

@implementation SSShieldResponse

+ (SSShieldResponse *)parse:(NSData *)data
{
    NSError *error = nil;
    id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    SSShieldResponse *response = [SSShieldResponse new];
    response.shieldOffer = [SSShieldOffer decodeFromJSON:responseObject];
    return response;
}

@end
