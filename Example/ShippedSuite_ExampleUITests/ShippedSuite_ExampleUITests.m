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
    XCUIElement *switchElement = self.app.switches[@"Switch"];
    XCUIElement *logoElement = self.app.images[@"Logo"];
    
    XCTAssertTrue(switchElement.exists || logoElement.exists);
    if (switchElement.exists) {
        [switchElement tap];
    }
    
    XCUIElement *learnMoreElement = self.app.buttons[@"Learn More"];
    XCTAssertTrue(learnMoreElement.exists);
    [learnMoreElement tap];
    
    XCUIElement *doneElement = self.app.buttons[@"Close Learn More Modal"];
    [self waitForElement:doneElement duration:10];
    XCTAssertTrue(doneElement.exists);
    [doneElement tap];
    
    XCUIElement *displayModalElement = self.app.buttons[@"Display Learn More Modal"];
    XCTAssertTrue(displayModalElement.exists);
    [displayModalElement tap];
    
    XCUIElement *viewFullElement = self.app.images[@"green_banner"];
    [self waitForElement:viewFullElement duration:10];
    XCTAssertTrue(viewFullElement.exists);
    [viewFullElement tap];
    
    doneElement = self.app.buttons[@"Done"];
    [self waitForElement:doneElement duration:10];
    XCTAssertTrue(doneElement.exists);
    [doneElement tap];
    
    XCUIElement *viewTerms = self.app.buttons[@"Terms of Service"];
    [self waitForElement:viewTerms duration:10];
    XCTAssertTrue(viewTerms.exists);
    [viewTerms tap];
    
    doneElement = self.app.buttons[@"Done"];
    [self waitForElement:doneElement duration:10];
    XCTAssertTrue(doneElement.exists);
    [doneElement tap];
    
    XCUIElement *viewPrivacy = self.app.buttons[@"Privacy Policy"];
    [self waitForElement:viewPrivacy duration:10];
    XCTAssertTrue(viewPrivacy.exists);
    [viewPrivacy tap];
    
    doneElement = self.app.buttons[@"Done"];
    [self waitForElement:doneElement duration:10];
    XCTAssertTrue(doneElement.exists);
    [doneElement tap];
    
    XCUIElement *viewDownload = self.app.buttons[@"Download Shipped"];
    [self waitForElement:viewDownload duration:10];
    XCTAssertTrue(viewDownload.exists);
    [viewDownload tap];
    
    doneElement = self.app.buttons[@"Done"];
    [self waitForElement:doneElement duration:10];
    XCTAssertTrue(doneElement.exists);
    [doneElement tap];
    
    doneElement = self.app.buttons[@"Close Learn More Modal"];
    [self waitForElement:doneElement duration:10];
    XCTAssertTrue(doneElement.exists);
    [doneElement tap];
    
    XCUIElement *sendRequestElement = self.app.buttons[@"Send Offers Fee Request"];
    XCTAssertTrue(sendRequestElement.exists);
    [sendRequestElement tap];
    
    XCTAssertTrue([sendRequestElement waitForExistenceWithTimeout:5]);
}

@end
