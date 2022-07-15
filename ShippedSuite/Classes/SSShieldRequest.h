//
//  SSShieldRequest.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSNetworking.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `SSShieldRequest` includes the request of getting shield fee.
 */
@interface SSShieldRequest : SSRequest

/**
 An order value.
 */
@property (nonatomic, copy) NSDecimalNumber *orderValue;

@end

NS_ASSUME_NONNULL_END
