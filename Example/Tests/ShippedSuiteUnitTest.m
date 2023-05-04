//
//  ShippedSuiteUnitTest.m
//  ShippedSuite_Tests
//
//  Created by Victor Zhu on 2022/5/24.
//  Copyright (c) 2022 Invisible Commerce Limited. All rights reserved.
//

@import XCTest;
@import ShippedSuite;

@interface ShippedSuiteUnitTest : XCTestCase

@end

@implementation ShippedSuiteUnitTest

- (void)setUp
{
    [super setUp];
    [ShippedSuite configurePublicKey:@"pk_development_117c2ee46c122fb0ce070fbc984e6a4742040f05a1c73f8a900254a1933a0112"];
    [ShippedSuite setMode:ShippedSuiteModeDevelopment];
    [ShippedSuite setDefaultBaseURL:nil];
}

- (void)testProductionMode
{
    [ShippedSuite setMode:ShippedSuiteModeProduction];
    XCTAssertEqual([ShippedSuite mode], ShippedSuiteModeProduction);
    XCTAssertEqualObjects([ShippedSuite defaultBaseURL], [NSURL URLWithString:@"https://api.shippedsuite.com/"]);
}

- (void)testDevelopmentMode
{
    [ShippedSuite setMode:ShippedSuiteModeDevelopment];
    XCTAssertEqual([ShippedSuite mode], ShippedSuiteModeDevelopment);
    XCTAssertEqualObjects([ShippedSuite defaultBaseURL], [NSURL URLWithString:@"https://api-staging.shippedsuite.com/"]);
}

- (void)testDefaultURL
{
    [ShippedSuite setDefaultBaseURL:[NSURL URLWithString:@"https://api-staging.shippedsuite.com/"]];
    XCTAssertEqualObjects([ShippedSuite defaultBaseURL], [NSURL URLWithString:@"https://api-staging.shippedsuite.com/"]);
}

- (void)testConfiguration
{
    ShippedSuiteConfiguration *configuration = [ShippedSuiteConfiguration new];
    configuration.type = ShippedSuiteTypeGreen;
    configuration.isInformational = YES;
    configuration.isMandatory = YES;
    configuration.isRespectServer = YES;
    configuration.appearance = ShippedSuiteAppearanceAuto;

    XCTAssertEqual(configuration.type, ShippedSuiteTypeGreen);
    XCTAssertEqual(configuration.isInformational, YES);
    XCTAssertEqual(configuration.isMandatory, YES);
    XCTAssertEqual(configuration.isRespectServer, YES);
}

- (void)testGreen
{
    XCTestExpectation *waitExpectation = [[XCTestExpectation alloc] initWithDescription:@"Waiting"];
    
    ShippedSuiteConfiguration *configuration = [ShippedSuiteConfiguration new];
    configuration.type = ShippedSuiteTypeGreen;
    configuration.isInformational = NO;
    configuration.isMandatory = NO;
    configuration.isRespectServer = NO;
    configuration.appearance = ShippedSuiteAppearanceDark;

    SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectZero];
    widgetView.configuration = configuration;
    [widgetView updateOrderValue:[NSDecimalNumber decimalNumberWithString:@"129.99"]];
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
        XCTAssertNotNil(widgetView);
        [waitExpectation fulfill];
    }];
    [self waitForExpectations:@[waitExpectation] timeout:8];
}

- (void)testShield
{
    XCTestExpectation *waitExpectation = [[XCTestExpectation alloc] initWithDescription:@"Waiting"];
    
    ShippedSuiteConfiguration *configuration = [ShippedSuiteConfiguration new];
    configuration.type = ShippedSuiteTypeShield;
    configuration.isInformational = NO;
    configuration.isMandatory = NO;
    configuration.isRespectServer = NO;
    configuration.appearance = ShippedSuiteAppearanceDark;

    SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectZero];
    widgetView.configuration = configuration;
    [widgetView updateOrderValue:[NSDecimalNumber decimalNumberWithString:@"129.99"]];
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
        XCTAssertNotNil(widgetView);
        [waitExpectation fulfill];
    }];
    [self waitForExpectations:@[waitExpectation] timeout:8];
}

- (void)testGreenAndShield
{
    XCTestExpectation *waitExpectation = [[XCTestExpectation alloc] initWithDescription:@"Waiting"];
    
    ShippedSuiteConfiguration *configuration = [ShippedSuiteConfiguration new];
    configuration.type = ShippedSuiteTypeGreenAndShield;
    configuration.isInformational = NO;
    configuration.isMandatory = NO;
    configuration.isRespectServer = NO;
    configuration.appearance = ShippedSuiteAppearanceDark;

    SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectZero];
    widgetView.configuration = configuration;
    [widgetView updateOrderValue:[NSDecimalNumber decimalNumberWithString:@"129.99"]];
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
        XCTAssertNotNil(widgetView);
        [waitExpectation fulfill];
    }];
    [self waitForExpectations:@[waitExpectation] timeout:8];
}

- (void)testIsRespectServer
{
    XCTestExpectation *waitExpectation = [[XCTestExpectation alloc] initWithDescription:@"Waiting"];
    
    ShippedSuiteConfiguration *configuration = [ShippedSuiteConfiguration new];
    configuration.type = ShippedSuiteTypeShield;
    configuration.isInformational = NO;
    configuration.isMandatory = NO;
    configuration.isRespectServer = YES;
    configuration.appearance = ShippedSuiteAppearanceDark;

    SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectZero];
    widgetView.configuration = configuration;
    [widgetView updateOrderValue:[NSDecimalNumber decimalNumberWithString:@"129.99"]];
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
        XCTAssertNotNil(widgetView);
        [waitExpectation fulfill];
    }];
    [self waitForExpectations:@[waitExpectation] timeout:8];
}

- (void)testIsMandatory
{
    XCTestExpectation *waitExpectation = [[XCTestExpectation alloc] initWithDescription:@"Waiting"];
    
    ShippedSuiteConfiguration *configuration = [ShippedSuiteConfiguration new];
    configuration.type = ShippedSuiteTypeShield;
    configuration.isInformational = NO;
    configuration.isMandatory = YES;
    configuration.isRespectServer = NO;
    configuration.appearance = ShippedSuiteAppearanceLight;

    SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectZero];
    widgetView.configuration = configuration;
    [widgetView updateOrderValue:[NSDecimalNumber decimalNumberWithString:@"129.99"]];
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
        XCTAssertNotNil(widgetView);
        [waitExpectation fulfill];
    }];
    [self waitForExpectations:@[waitExpectation] timeout:8];
}

- (void)testIsInformational
{
    XCTestExpectation *waitExpectation = [[XCTestExpectation alloc] initWithDescription:@"Waiting"];
    
    ShippedSuiteConfiguration *configuration = [ShippedSuiteConfiguration new];
    configuration.type = ShippedSuiteTypeShield;
    configuration.isInformational = YES;
    configuration.isMandatory = YES;
    configuration.isRespectServer = NO;
    configuration.appearance = ShippedSuiteAppearanceLight;

    SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectZero];
    widgetView.configuration = configuration;
    [widgetView updateOrderValue:[NSDecimalNumber decimalNumberWithString:@"129.99"]];
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
        XCTAssertNotNil(widgetView);
        [waitExpectation fulfill];
    }];
    [self waitForExpectations:@[waitExpectation] timeout:8];
}

- (void)testFailureOnWidgetView
{
    [ShippedSuite setMode:ShippedSuiteModeProduction];
    XCTestExpectation *waitExpectation = [[XCTestExpectation alloc] initWithDescription:@"Waiting"];
    
    ShippedSuiteConfiguration *configuration = [ShippedSuiteConfiguration new];
    configuration.type = ShippedSuiteTypeShield;
    configuration.isInformational = YES;
    configuration.isMandatory = YES;
    configuration.isRespectServer = YES;
    configuration.appearance = ShippedSuiteAppearanceLight;

    SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectZero];
    widgetView.configuration = configuration;
    [widgetView updateOrderValue:[NSDecimalNumber decimalNumberWithString:@"129.99"]];
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
        XCTAssertNotNil(widgetView);
        [waitExpectation fulfill];
    }];
    [self waitForExpectations:@[waitExpectation] timeout:8];
}

- (void)testRequest
{
    SSHTTPRequest *request = [SSHTTPRequest new];
    XCTAssertThrows(request.path);
    XCTAssertTrue(request.method == SSHTTPMethodGET);
    XCTAssertNotNil(request.headers);
    XCTAssertNil(request.parameters);
    XCTAssertNil(request.postData);
    XCTAssertNil(request.responseClass);
}

- (void)testResponse
{
    NSData *data = [NSData new];
    XCTAssertThrows([SSHTTPResponse parse:data]);
    XCTAssertNil([SSHTTPResponse parseError:data code:-1]);
    
    NSDictionary *correctJson = @{@"green_fee": @"0.29", @"mandatory": @YES, @"offered_at": @"2022-08-19T05:59:18.891-07:00", @"order_value": @"129.99", @"shield_fee": @"2.27", @"storefront_id": @"test-paws.myshopify.com"};
    XCTAssertNotNil([SSOffers decodeFromJSON:correctJson]);
}

- (void)testResponseWithNull
{
    NSDictionary *correctJson = @{@"green_fee": [NSNull null], @"mandatory": @YES, @"offered_at": @"2022-08-19T05:59:18.891-07:00", @"order_value": @"129.99", @"shield_fee": @"2.27", @"storefront_id": @"test-paws.myshopify.com"};
    SSOffers *offers = [SSOffers decodeFromJSON:correctJson];
    XCTAssertNotNil(offers);
    XCTAssertNil(offers.greenFee);
}

- (void)testOffersFee
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"track test"];
    NSDecimalNumber *orderValue = [NSDecimalNumber decimalNumberWithString:@"129.99"];
    [ShippedSuite getOffersFee:orderValue currency:@"EUR" completion:^(SSOffers * _Nullable offers, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertEqualObjects(offers.orderValue, orderValue);
        XCTAssertEqualObjects(offers.shieldFee.stringValue, @"2.27");
        XCTAssertEqualObjects(offers.greenFee.stringValue, @"0.39");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testLogger
{
    [SSLogger sharedLogger].enableLogPrinted = YES;
    [[SSLogger sharedLogger] logEvent:@"test"];
    [[SSLogger sharedLogger] logEvent:@"test" parameters:@{@"param": @"value"}];
    XCTAssertThrows([[SSLogger sharedLogger] logException:@"exception"]);
}

- (void)testUtils
{
    BOOL isIpad = [UIDevice isIpad];
    XCTAssertFalse(isIpad);
    
    UIColor *color = [UIColor colorWithHex:0x000000];
    XCTAssertNotNil(color);
    
    NSDictionary *queryDict = @{@"a": @"b", @"c": @"d"};
    NSString *query = [queryDict queryURLEncoding];
    XCTAssertEqualObjects(query, @"a=b&c=d");
    
    NSString *dateString = @"2022-05-23T23:47:27.738-07:00";
    NSDate *date = [NSDate dateFromString:dateString];
    XCTAssertNotNil(date);
    
    UIEdgeInsets insets = [UIWindow safeAreaInsets];
    XCTAssertTrue(insets.top > 0);
}

- (void)testFailure
{
    [ShippedSuite setMode:ShippedSuiteModeProduction];
    XCTestExpectation *expectation = [self expectationWithDescription:@"track test"];
    NSDecimalNumber *orderValue = [NSDecimalNumber decimalNumberWithString:@"129.99"];
    [ShippedSuite getOffersFee:orderValue completion:^(SSOffers * _Nullable offers, NSError * _Nullable error) {
        XCTAssertNotNil(error);
        XCTAssertNil(offers);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testTitleColor
{
    UIColor *color0 = [UIColor titleColorFor:ShippedSuiteAppearanceAuto];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor titleColorFor:ShippedSuiteAppearanceLight];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor titleColorFor:ShippedSuiteAppearanceDark];
    XCTAssertNotNil(color2);
}

- (void)testLearnMoreColor
{
    UIColor *color0 = [UIColor learnMoreColorFor:ShippedSuiteAppearanceAuto];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor learnMoreColorFor:ShippedSuiteAppearanceLight];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor learnMoreColorFor:ShippedSuiteAppearanceDark];
    XCTAssertNotNil(color2);
}

- (void)testFeeColor
{
    UIColor *color0 = [UIColor feeColorFor:ShippedSuiteAppearanceAuto];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor feeColorFor:ShippedSuiteAppearanceLight];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor feeColorFor:ShippedSuiteAppearanceDark];
    XCTAssertNotNil(color2);
}

- (void)testDescColor
{
    UIColor *color0 = [UIColor descColorFor:ShippedSuiteAppearanceAuto];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor descColorFor:ShippedSuiteAppearanceLight];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor descColorFor:ShippedSuiteAppearanceDark];
    XCTAssertNotNil(color2);
}

- (void)testModalBackgroundColor
{
    UIColor *color0 = [UIColor modalBackgroundColorFor:ShippedSuiteAppearanceAuto];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor modalBackgroundColorFor:ShippedSuiteAppearanceLight];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor modalBackgroundColorFor:ShippedSuiteAppearanceDark];
    XCTAssertNotNil(color2);
}

- (void)testModalHeaderColor
{
    UIColor *color0 = [UIColor modalHeaderColorFor:ShippedSuiteAppearanceAuto];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor modalHeaderColorFor:ShippedSuiteAppearanceLight];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor modalHeaderColorFor:ShippedSuiteAppearanceDark];
    XCTAssertNotNil(color2);
}

- (void)testModalTitleColor
{
    UIColor *color0 = [UIColor modalTitleColorFor:ShippedSuiteAppearanceAuto];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor modalTitleColorFor:ShippedSuiteAppearanceLight];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor modalTitleColorFor:ShippedSuiteAppearanceDark];
    XCTAssertNotNil(color2);
}

- (void)testModalSubtitleColor
{
    UIColor *color0 = [UIColor modalSubtitleColorFor:ShippedSuiteAppearanceAuto];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor modalSubtitleColorFor:ShippedSuiteAppearanceLight];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor modalSubtitleColorFor:ShippedSuiteAppearanceDark];
    XCTAssertNotNil(color2);
}

- (void)testModalActionViewColor
{
    UIColor *color0 = [UIColor modalActionViewColorFor:ShippedSuiteAppearanceAuto type:ShippedSuiteTypeShield];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor modalActionViewColorFor:ShippedSuiteAppearanceLight type:ShippedSuiteTypeGreen];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor modalActionViewColorFor:ShippedSuiteAppearanceDark type:ShippedSuiteTypeGreenAndShield];
    XCTAssertNotNil(color2);
}

- (void)testModalActionTextColor
{
    UIColor *color0 = [UIColor modalActionTextColorFor:ShippedSuiteAppearanceAuto];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor modalActionTextColorFor:ShippedSuiteAppearanceLight];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor modalActionTextColorFor:ShippedSuiteAppearanceDark];
    XCTAssertNotNil(color2);
}

- (void)testModalActionLineColor
{
    UIColor *color0 = [UIColor modalActionLineColorFor:ShippedSuiteAppearanceAuto];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor modalActionLineColorFor:ShippedSuiteAppearanceLight];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor modalActionLineColorFor:ShippedSuiteAppearanceDark];
    XCTAssertNotNil(color2);
}

- (void)testModalActionLinkColor
{
    UIColor *color0 = [UIColor modalActionLinkColorFor:ShippedSuiteAppearanceAuto];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor modalActionLinkColorFor:ShippedSuiteAppearanceLight];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor modalActionLinkColorFor:ShippedSuiteAppearanceDark];
    XCTAssertNotNil(color2);
}

- (void)testModalCTABackgroundColor
{
    UIColor *color0 = [UIColor modalCTABackgroundColorFor:ShippedSuiteAppearanceAuto];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor modalCTABackgroundColorFor:ShippedSuiteAppearanceLight];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor modalCTABackgroundColorFor:ShippedSuiteAppearanceDark];
    XCTAssertNotNil(color2);
}

- (void)testModalCTATextColor
{
    UIColor *color0 = [UIColor modalCTATextColorFor:ShippedSuiteAppearanceAuto];
    XCTAssertNotNil(color0);
    UIColor *color1 = [UIColor modalCTATextColorFor:ShippedSuiteAppearanceLight];
    XCTAssertNotNil(color1);
    UIColor *color2 = [UIColor modalCTATextColorFor:ShippedSuiteAppearanceDark];
    XCTAssertNotNil(color2);
}

- (void)testCurrencyFormattedString
{
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"299.99"];
    XCTAssertNotNil([amount currencyStringWithSymbol:@"$" code:@"USD" space:@" " decimalSeparator:@"." usesGroupingSeparator:YES groupingSeparator:@"," fractionDigits:2 symbolFirst:NO]);
}

@end
