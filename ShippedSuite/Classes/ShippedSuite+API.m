//
//  ShippedSuite+API.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/14.
//

#import "ShippedSuite+API.h"
#import "SSNetworking.h"
#import "SSShieldRequest.h"
#import "SSShieldResponse.h"

@implementation ShippedSuite (API)

+ (void)getShieldFee:(NSDecimalNumber *)orderValue completion:(ShippedSuiteFeeHandler)completion
{
    SSShieldRequest *request = [SSShieldRequest new];
    request.orderValue = orderValue;
    [[SSAPIClient sharedClient] send:request handler:^(SSResponse * _Nullable response, NSError * _Nullable error) {
        if (!error && response && [response isKindOfClass:[SSShieldResponse class]]) {
            SSShieldResponse *shieldResponse = (SSShieldResponse *)response;
            completion(shieldResponse.shieldOffer, error);
        } else {
            completion(nil, error);
        }
    }];
}
@end
