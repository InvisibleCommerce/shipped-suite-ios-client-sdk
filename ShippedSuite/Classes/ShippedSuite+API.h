//
//  ShippedSuite+API.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/14.
//

#import "ShippedSuite.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ShippedSuiteFeeHandler)(SSShieldOffer * _Nullable offer, NSError * _Nullable error);

@interface ShippedSuite (API)

/**
 Get shield fee.
 
 @param orderValue An order value.
 @param completion A handler which includes shield fee.
 */
+ (void)getShieldFee:(NSDecimalNumber *)orderValue completion:(ShippedSuiteFeeHandler)completion;

@end

NS_ASSUME_NONNULL_END
