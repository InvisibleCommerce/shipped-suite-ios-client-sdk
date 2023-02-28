//
//  ShippedSuite+Configuration.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2023/2/28.
//

#import "ShippedSuite+Configuration.h"

@implementation ShippedSuite (Configuration)

static NSString * const SSAPIStagingBaseURL = @"https://api-staging.shippedsuite.com/";
static NSString * const SSAPIProductionBaseURL = @"https://api.shippedsuite.com/";

static NSURL *_defaultBaseURL;

static ShippedSuiteMode _mode = ShippedSuiteModeDevelopment;

static NSString *_publicKey = nil;

static ShippedSuiteType _type = ShippedSuiteTypeShield;

static BOOL _isInformational = NO;

static BOOL _isMandatory = NO;

static BOOL _isRespectServer = NO;

+ (void)setDefaultBaseURL:(NSURL *)baseURL
{
    _defaultBaseURL = [baseURL URLByAppendingPathComponent:@""];
}

+ (NSURL *)defaultBaseURL
{
    if (_defaultBaseURL) {
        return _defaultBaseURL;
    }
    
    switch (_mode) {
        case ShippedSuiteModeDevelopment:
            return [NSURL URLWithString:SSAPIStagingBaseURL];
        case ShippedSuiteModeProduction:
            return [NSURL URLWithString:SSAPIProductionBaseURL];
    }
}

+ (void)setMode:(ShippedSuiteMode)mode
{
    _mode = mode;
}

+ (ShippedSuiteMode)mode
{
    return _mode;
}

+ (void)configurePublicKey:(NSString *)publicKey
{
    _publicKey = publicKey;
}

+ (NSString *)publicKey
{
    return _publicKey;
}

+ (void)setType:(ShippedSuiteType)type
{
    _type = type;
}

+ (ShippedSuiteType)type
{
    return _type;
}

+ (void)setIsInformational:(BOOL)isInformational
{
    _isInformational = isInformational;
}

+ (BOOL)isInformational
{
    return _isInformational;
}

+ (void)setIsMandatory:(BOOL)isMandatory
{
    _isMandatory = isMandatory;
}

+ (BOOL)isMandatory
{
    return _isMandatory;
}

+ (void)setIsRespectServer:(BOOL)isRespectServer
{
    _isRespectServer = isRespectServer;
}

+ (BOOL)isRespectServer
{
    return _isRespectServer;
}

@end
