//
//  SSOffersRequest.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSOffersRequest.h"
#import "SSOffersResponse.h"

@implementation SSOffersRequest

- (NSString *)path
{
    return @"/v1/offers";
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
    return SSOffersResponse.class;
}

@end
