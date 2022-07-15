//
//  SSShieldRequest.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSShieldRequest.h"
#import "SSShieldResponse.h"

@implementation SSShieldRequest

- (NSString *)path
{
    return @"/v1/shield_offers";
}

- (SSHTTPMethod)method
{
    return SSHTTPMethodPOST;
}

- (nullable NSDictionary *)parameters
{
    return @{@"order_value": self.orderValue.stringValue};
}

- (Class)responseClass
{
    return SSShieldResponse.class;
}

@end
