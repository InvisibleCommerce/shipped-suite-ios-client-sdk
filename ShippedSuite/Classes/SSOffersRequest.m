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
    NSMutableDictionary *_parameters = [NSMutableDictionary dictionary];
    _parameters[@"order_value"] = self.orderValue.stringValue;
    if (self.currency) {
        _parameters[@"currency"] = self.currency;
    }
    return _parameters;
}

- (Class)responseClass
{
    return SSOffersResponse.class;
}

@end
