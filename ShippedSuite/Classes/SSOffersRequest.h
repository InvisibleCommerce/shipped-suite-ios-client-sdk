//
//  SSOffersRequest.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSNetworking.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `SSOffersRequest` includes the request of getting shield and green fee.
 */
@interface SSOffersRequest : SSHTTPRequest

/**
 An order value.
 */
@property (nonatomic, copy) NSDecimalNumber *orderValue;

/**
 A currency code.
 */
@property (nonatomic, copy) NSString *currency;

@end

NS_ASSUME_NONNULL_END
