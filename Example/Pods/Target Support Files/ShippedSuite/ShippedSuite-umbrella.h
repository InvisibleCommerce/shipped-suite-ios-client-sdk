#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ShippedSuite+API.h"
#import "ShippedSuite.h"
#import "SSConfiguration.h"
#import "SSLearnMoreViewController.h"
#import "SSLogger.h"
#import "SSNetworking.h"
#import "SSOffersRequest.h"
#import "SSOffersResponse.h"
#import "SSUtils.h"
#import "SSWidgetView.h"

FOUNDATION_EXPORT double ShippedSuiteVersionNumber;
FOUNDATION_EXPORT const unsigned char ShippedSuiteVersionString[];

