//
//  SSNetworking.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSNetworking.h"
#import "SSLogger.h"
#import "SSUtils.h"

static NSString * const SSAPIStagingBaseURL = @"https://api-staging.shippedsuite.com/";
static NSString * const SSAPIProductionBaseURL = @"https://api.shippedsuite.com/";

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

NSErrorDomain const SSSDKErrorDomain = @"com.invisiblecommerce.ShippedSuite.error";

#else

NSString *const SSSDKErrorDomain = @"com.invisiblecommerce.ShippedSuite.error";

#endif

@implementation ShippedSuite

static NSURL *_defaultBaseURL;

static ShippedSuiteMode _mode = ShippedSuiteModeDevelopment;

static NSString *_publicKey = nil;

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

@end

@implementation SSHTTPRequest

- (NSString *)path
{
    [[SSLogger sharedLogger] logException:NSLocalizedString(@"path required", nil)];
    return nil;
}

- (SSHTTPMethod)method
{
    return SSHTTPMethodGET;
}

- (NSDictionary *)headers
{
    return @{@"Content-Type": @"application/json"};
}

- (nullable NSDictionary *)parameters
{
    return nil;
}

- (nullable NSData *)postData
{
    return nil;
}

- (Class)responseClass
{
    [[SSLogger sharedLogger] logEvent:NSLocalizedString(@"responseClass is not overridden, but is not required", nil)];
    return nil;
}

@end

@implementation SSHTTPResponse

+ (SSHTTPResponse *)parse:(NSData *)data
{
    [[SSLogger sharedLogger] logException:NSLocalizedString(@"parse method require override", nil)];
    return nil;
}

+ (nullable SSErrorResponse *)parseError:(NSData *)data
                                    code:(NSInteger)code
{
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (json == nil) {
        return nil;
    }
    NSString *message = json[@"error"];
    return [[SSErrorResponse alloc] initWithMessage:message code:code];
}

@end

@implementation SSErrorResponse

- (instancetype)initWithMessage:(NSString *)message code:(NSInteger)code
{
    if (self = [super init]) {
        _message = [message copy];
        _code = code;
    }
    return self;
}

- (NSError *)error
{
    return [NSError errorWithDomain:SSSDKErrorDomain
                               code:self.code
                           userInfo:@{NSLocalizedDescriptionKey: self.message}];
}

@end

@implementation SSAPIClient

+ (instancetype)sharedClient
{
    static SSAPIClient *sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [self new];
    });
    return sharedClient;
}

- (void)send:(SSHTTPRequest *)request handler:(SSHTTPRequestHandler)handler
{
    NSString *method = @"POST";
    NSURL *url = [NSURL URLWithString:request.path relativeToURL:[ShippedSuite defaultBaseURL]];
    
    if (request.method == SSHTTPMethodGET) {
        method = @"GET";
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", url.absoluteString, request.parameters ? [request.parameters queryURLEncoding] : @""]];
    }
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    urlRequest.HTTPMethod = method;
    
    NSDictionary *headers = request.headers;
    for (NSString *key in headers) {
        [urlRequest setValue:headers[key] forHTTPHeaderField:key];
    }
    if (_publicKey) {
        [urlRequest setValue:[NSString stringWithFormat:@"Bearer %@", _publicKey] forHTTPHeaderField:@"Authorization"];
    } else {
        NSLog(@"You must configure the SDK instance with a 'publicKey' property");
    }
    if (request.parameters && [NSJSONSerialization isValidJSONObject:request.parameters] && request.method == SSHTTPMethodPOST) {
        urlRequest.HTTPBody = [NSJSONSerialization dataWithJSONObject:request.parameters options:NSJSONWritingPrettyPrinted error:nil];
    }
    if (request.postData) {
        urlRequest.HTTPBody = request.postData;
    }
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (handler) {
            NSHTTPURLResponse *result = (NSHTTPURLResponse *)response;
            if (data && request.responseClass != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (result.statusCode >= 200 && result.statusCode < 300 && [request.responseClass respondsToSelector:@selector(parse:)]) {
                        id response = [request.responseClass performSelector:@selector(parse:) withObject:data];
                        handler(response, error);
                    } else {
                        SSErrorResponse *errorResponse = [request.responseClass performSelector:@selector(parseError:code:)
                                                                                     withObject:data
                                                                                     withObject:@(result.statusCode)];
                        if (errorResponse) {
                            handler(nil, errorResponse.error);
                        } else {
                            handler(nil, [NSError errorWithDomain:SSSDKErrorDomain
                                                             code:result.statusCode
                                                         userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Couldn't parse response.", nil)}]);
                        }
                    }
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(nil, error);
                });
            }
        }
    }];
    [task resume];
}

@end
