//
//  ShippedSuite+API.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/14.
//

#import "ShippedSuite+API.h"

@implementation ShippedSuite (API)

+ (void)getOffersFee:(NSDecimalNumber *)orderValue completion:(ShippedSuiteFeeHandler)completion
{
    [self getOffersFee:orderValue currency:nil completion:completion];
}

+ (void)getOffersFee:(NSDecimalNumber *)orderValue currency:(nullable NSString *)currency completion:(ShippedSuiteFeeHandler)completion
{
    SSOffersRequest *request = [SSOffersRequest new];
    request.orderValue = orderValue;
    request.currency = currency;
    [[SSAPIClient sharedClient] send:request handler:^(SSHTTPResponse * _Nullable response, NSError * _Nullable error) {
        if (!error && response && [response isKindOfClass:[SSOffersResponse class]]) {
            SSOffersResponse *offersResponse = (SSOffersResponse *)response;
            completion(offersResponse.offers, error);
        } else {
            completion(nil, error);
        }
    }];
}
@end
