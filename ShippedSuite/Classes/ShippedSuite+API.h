//
//  ShippedSuite+API.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/14.
//

#import "ShippedSuite.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ShippedSuiteFeeHandler)(SSOffers * _Nullable offers, NSError * _Nullable error);

@interface ShippedSuite (API)

/**
 Get shield and green fee.
 
 @param orderValue An order value.
 @param completion A handler which includes shield and green fee.
 */
+ (void)getOffersFee:(NSDecimalNumber *)orderValue completion:(ShippedSuiteFeeHandler)completion;

@end

NS_ASSUME_NONNULL_END
