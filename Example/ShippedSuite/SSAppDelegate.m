//
//  SSAppDelegate.m
//  ShippedSuite
//
//  Created by Victor Zhu on 04/07/2022.
//  Copyright (c) 2022 Invisible Commerce Limited. All rights reserved.
//

#import "SSAppDelegate.h"
#import <ShippedSuite/ShippedSuite.h>

@implementation SSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup ShippedSuite
    [ShippedSuite configurePublicKey:@"pk_development_117c2ee46c122fb0ce070fbc984e6a4742040f05a1c73f8a900254a1933a0112"];
    
    // Optional, the default mode is development mode
    [ShippedSuite setMode:ShippedSuiteModeDevelopment];
    
    // Widget & Learn more modal settings
    [ShippedSuite setType:ShippedSuiteTypeGreen];
    [ShippedSuite setIsRespectServer:NO];
    [ShippedSuite setIsMandatory:NO];
    [ShippedSuite setIsInformational:YES];
    
    return YES;
}

@end
