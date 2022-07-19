//
//  ShippedSuite+API.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/14.
//

#import "ShippedSuite+API.h"
#import "SSNetworking.h"
#import "SSOffersRequest.h"
#import "SSOffersResponse.h"

@implementation ShippedSuite (API)

+ (void)getOffersFee:(NSDecimalNumber *)orderValue completion:(ShippedSuiteFeeHandler)completion
{
    SSOffersRequest *request = [SSOffersRequest new];
    request.orderValue = orderValue;
    [[SSAPIClient sharedClient] send:request handler:^(SSResponse * _Nullable response, NSError * _Nullable error) {
        if (!error && response && [response isKindOfClass:[SSOffersResponse class]]) {
            SSOffersResponse *offersResponse = (SSOffersResponse *)response;
            completion(offersResponse.offers, error);
        } else {
            completion(nil, error);
        }
    }];
}
@end
