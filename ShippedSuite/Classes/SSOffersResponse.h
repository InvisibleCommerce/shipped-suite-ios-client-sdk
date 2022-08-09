//
//  SSOffersResponse.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSNetworking.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `SSOffers` includes the details of offers fee.
 */
@interface SSOffers : NSObject <SSJSONDecodable>

/**
 Storefront id.
 */
@property (nonatomic, copy) NSString *storefrontId;

/**
 Order value.
 */
@property (nonatomic, copy) NSDecimalNumber *orderValue;

/**
 Shield fee.
 */
@property (nonatomic, copy) NSDecimalNumber *shieldFee;

/**
 Green fee.
 */
@property (nonatomic, copy) NSDecimalNumber *greenFee;

/**
 The date offered at.
 */
@property (nonatomic, copy) NSDate *offeredAt;

@end

/**
 `SSOffersResponse` includes the response of offers fee.
 */
@interface SSOffersResponse : SSHTTPResponse

/**
 The offers object.
 */
@property (nonatomic, readonly) SSOffers *offers;

@end

NS_ASSUME_NONNULL_END
