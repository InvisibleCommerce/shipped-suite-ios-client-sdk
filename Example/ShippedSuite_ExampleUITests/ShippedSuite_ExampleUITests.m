//
//  ShippedSuite_ExampleUITests.m
//  ShippedSuite_ExampleUITests
//
//  Created by Victor Zhu on 2022/5/24.
//  Copyright (c) 2022 Invisible Commerce Limited. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCTestCase+Utils.h"
#import "XCUIElementQuery+Utils.h"

@interface ShippedSuite_ExampleUITests : XCTestCase

@property (nonatomic, strong) XCUIApplication *app;

@end

@implementation ShippedSuite_ExampleUITests

- (void)setUp {
    self.continueAfterFailure = NO;
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
}

- (void)testExample {
    XCUIElement *switchElement = self.app.switches[@"Shield switch"];
    XCTAssertTrue(switchElement.exists);
    [switchElement tap];
    
    XCUIElement *learnMoreElement = self.app.buttons[@"Learn More"];
    XCTAssertTrue(learnMoreElement.exists);
    [learnMoreElement tap];
    
    XCUIElement *doneElement = self.app.buttons[@"Done"];
    [self waitForElement:doneElement duration:10];
    XCTAssertTrue(doneElement.exists);
    [doneElement tap];
    
    XCUIElement *displayModalElement = self.app.buttons[@"Display Learn More Modal"];
    XCTAssertTrue(displayModalElement.exists);
    [displayModalElement tap];
    
    doneElement = self.app.buttons[@"Done"];
    [self waitForElement:doneElement duration:10];
    XCTAssertTrue(doneElement.exists);
    [doneElement tap];
    
    XCUIElement *sendRequestElement = self.app.buttons[@"Send Shield Fee Request"];
    XCTAssertTrue(sendRequestElement.exists);
    [sendRequestElement tap];
}

@end
