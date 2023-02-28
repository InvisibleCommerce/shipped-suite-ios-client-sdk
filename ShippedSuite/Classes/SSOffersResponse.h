//
//  SSOffersResponse.h
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSNetworking.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `SSCurrency` includes the details of currency.
 */
@interface SSCurrency : NSObject <SSJSONDecodable>

/**
 Decimal mark.
 */
@property (nonatomic, copy) NSString *decimalMark;

/**
 Symbol.
 */
@property (nonatomic, copy) NSString *symbol;

/**
 Symbol first.
 */
@property (nonatomic) BOOL symbolFirst;

/**
 Thousands separator.
 */
@property (nonatomic, copy) NSString *thousandsSeparator;

/**
 Subunit to unit.
 */
@property (nonatomic, copy) NSDecimalNumber *subunitToUnit;

/**
 ISO code
 */
@property (nonatomic, copy) NSString *isoCode;

/**
 Name.
 */
@property (nonatomic, copy) NSString *name;

@end

/**
 `SSFeeWithCurrency` includes the details of offers fee with currency.
 */
@interface SSFeeWithCurrency : NSObject <SSJSONDecodable>

/**
 Currency object.
 */
@property (nonatomic, strong) SSCurrency *currency;

/**
 Subunits.
 */
@property (nonatomic, copy) NSDecimalNumber *subunits;

/**
 Formatted fee.
 */
@property (nonatomic, copy) NSString *formatted;

@end

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
 Shield fee currency.
 */
@property (nonatomic, strong) SSFeeWithCurrency *shieldFeeWithCurrency;

/**
 Green fee.
 */
@property (nonatomic, copy) NSDecimalNumber *greenFee;

/**
 Green fee currency.
 */
@property (nonatomic, strong) SSFeeWithCurrency *greenFeeWithCurrency;

/**
 Is mandatory.
 */
@property (nonatomic) BOOL isMandatory;

/**
 The date offered at.
 */
@property (nonatomic, copy) NSDate *offeredAt;

- (BOOL)isShieldAvailable;
- (BOOL)isGreenAvailable;

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
