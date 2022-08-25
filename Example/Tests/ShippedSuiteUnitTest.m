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

- (void)testGreen
{
    XCTestExpectation *waitExpectation = [[XCTestExpectation alloc] initWithDescription:@"Waiting"];

    SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectZero];
    widgetView.type = ShippedSuiteTypeGreen;
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

    SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectZero];
    widgetView.type = ShippedSuiteTypeShield;
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

    SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectZero];
    widgetView.type = ShippedSuiteTypeGreenAndShield;
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

    SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectZero];
    widgetView.type = ShippedSuiteTypeGreenAndShield;
    widgetView.isRespectServer = YES;
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

    SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectZero];
    widgetView.type = ShippedSuiteTypeGreenAndShield;
    widgetView.isRespectServer = YES;
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
    
    NSDictionary *correctJson = @{@"green_fee": @"0.29", @"offered_at": @"2022-08-19T05:59:18.891-07:00", @"order_value": @"129.99", @"shield_fee": @"2.27", @"storefront_id": @"test-paws.myshopify.com"};
    XCTAssertNotNil([SSOffers decodeFromJSON:correctJson]);
}

- (void)testResponseWithNull
{
    NSDictionary *correctJson = @{@"green_fee": [NSNull null], @"offered_at": @"2022-08-19T05:59:18.891-07:00", @"order_value": @"129.99", @"shield_fee": @"2.27", @"storefront_id": @"test-paws.myshopify.com"};
    SSOffers *offers = [SSOffers decodeFromJSON:correctJson];
    XCTAssertNotNil(offers);
    XCTAssertNil(offers.greenFee);
}

- (void)testOffersFee
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"track test"];
    NSDecimalNumber *orderValue = [NSDecimalNumber decimalNumberWithString:@"129.99"];
    [ShippedSuite getOffersFee:orderValue completion:^(SSOffers * _Nullable offers, NSError * _Nullable error) {
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
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

@end
