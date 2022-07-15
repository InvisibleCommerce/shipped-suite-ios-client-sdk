//
//  XCUIElementQuery+Utils.m
//  ShippedSuite_ExampleUITests
//
//  Created by Victor Zhu on 2022/5/24.
//  Copyright (c) 2022 Invisible Commerce Limited. All rights reserved.
//

#import "XCUIElementQuery+Utils.h"

@implementation XCUIElementQuery (Utils)

- (XCUIElement *)softMatchingWithSubstring:(NSString *)substring
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"label CONTAINS[cd] %@", substring];
    return [self elementMatchingPredicate:predicate].firstMatch;
}

@end
