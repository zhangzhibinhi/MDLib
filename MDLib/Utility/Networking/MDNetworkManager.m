//
//  MDNetworkManager.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/30.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "MDNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "DES3Util.h"
#import "MDDefines.h"
#import "MDUtility.h"
#import "NSDictionary+MDLib.h"

NSString *const kNetworkResumeAviliableNotification = @"kNetworkResumeAviliableNotification";
NSString *const kShouldIgnoreCommonParamsKey = @"kShouldIgnoreCommonParamsKey";
NSString *const kShouldIgnoreParamsSignKey = @"kShouldIgnoreParamsSignKey";

@interface MDNetworkManager ()<NSURLSessionTaskDelegate>

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableArray *debugQueue;

@end

@implementation MDNetworkManager

+ (void)load {
    __weak id obser = nil;
    obser = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [[MDNetworkManager sharedManager] startNetworkAviliableNotifier];
        [[NSNotificationCenter defaultCenter] removeObserver:obser];
    }];
}

+ (instancetype)sharedManager {
    static id _s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _s_instance = [[self alloc] init];
    });
    return _s_instance;
}

+ (BOOL)hasNetwork {
    return [[self sharedManager] isNetworkAviliable];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isNetworkAviliable = YES;

#if DEBUG
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            [self outputDebugInfoAndClean];
        }];
#endif
    }
    return self;
}

- (NSMutableArray *)debugQueue {
    if (!_debugQueue) {
        _debugQueue = [NSMutableArray new];
    }

    return _debugQueue;
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = 30;
        _sessionManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"image/jpg", @"text/plain", nil];
    }
    NSString *tokenStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [_sessionManager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"token"];
    return _sessionManager;
}

#pragma mark - public methods
- (void)startNetworkAviliableNotifier {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable ||
            status == AFNetworkReachabilityStatusUnknown) {
            NSLog(@"network access lost !!");
            self->_isNetworkAviliable = NO;
        }
        else {
            NSLog(@"network access is ready isWAN %d isWifi %d", (status == AFNetworkReachabilityStatusReachableViaWWAN), (status == AFNetworkReachabilityStatusReachableViaWiFi));
            self->_isNetworkAviliable = YES;
            dispatch_async(dispatch_get_main_queue(), ^{

                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", status] forKey:@"netStatus"];

                [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkResumeAviliableNotification object:nil userInfo:@{@"status":[NSString stringWithFormat:@"%ld", status]}];
            });
        }
    }];

    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark - get methods
- (NSURLSessionTask *)getRequestWithParams:(NSDictionary *)params
                                         apiPath:(NSString *)apiPath
                                 completeHandler:(ApiCompleteHandler)handler {
    return [self getWithParams:params apiHostUrl:[self apiHostUrl] apiPath:apiPath completeHandler:handler];
}

- (NSURLSessionTask *)getWithParams:(NSDictionary *)params
         apiHostUrl:(NSString *)hostUrl
            apiPath:(NSString *)apiPath
    completeHandler:(ApiCompleteHandler)handler {

    NSString *apiHostUrl = hostUrl.length > 0 ? hostUrl : [self apiHostUrl];

    params = [self configureCommonParams:params];

#if DEBUG
    [self appendDebugRequestWithMethod:@"get" apiPath:apiPath params:params];
#endif
    WEAK_SELF_DEFINE(weakSelf);
    NSURLSessionTask *task = [self.sessionManager GET:[apiHostUrl stringByAppendingString:apiPath] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf pharseResponseObject:responseObject withCompleteHandler:handler];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(error, nil, nil);
        });
    }];
    return task;
}

#pragma mark - post methods
- (NSURLSessionTask *)postRequestWithParams:(NSDictionary *)params
                                          apiPath:(NSString *)apiPath
                                  completeHandler:(ApiCompleteHandler)handler {
    return [self postRequestWithParams:params apiHostUrl:[self apiHostUrl] apiPath:apiPath completeHandler:handler];
}

- (NSURLSessionTask *)postRequestWithParams:(NSDictionary *)params
                 apiHostUrl:(NSString *)hostUrl
                    apiPath:(NSString *)apiPath
            completeHandler:(ApiCompleteHandler)handler {

    NSString *apiHostUrl = hostUrl.length > 0 ? hostUrl : [self apiHostUrl];

    params = [self configureCommonParams:params];

#if DEBUG
    [self appendDebugRequestWithMethod:@"post" apiPath:apiPath params:params];
#endif
    WEAK_SELF_DEFINE(weakSelf);
    NSURLSessionTask *task = [self.sessionManager POST:[apiHostUrl stringByAppendingString:apiPath] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf pharseResponseObject:responseObject withCompleteHandler:handler];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(error, nil, nil);
        });
    }];
    return task;
}

- (void)pharseResponseObject:(id)responseObject withCompleteHandler:(ApiCompleteHandler)handler {
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(nil, responseObject, responseObject);
        });
        return;
    }
    if ([responseObject intValueForKey:@"result" defaultValue:-1] == 200) {
        id pharseObject = [responseObject objectForKey:@"data"];
        if (pharseObject == nil || [pharseObject isKindOfClass:[NSNull class]]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil, responseObject, nil);
            });
        } else if ([responseObject intValueForKey:@"isdes" defaultValue:0] == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil, responseObject, pharseObject);
            });
        } else {
            NSString *resultJson = [DES3Util decrypt:[responseObject objectForKey:@"data"]];
            NSError *error = nil;
            id resultObj = [NSJSONSerialization JSONObjectWithData:[resultJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(error, responseObject, resultJson);
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(nil, responseObject, resultObj);
                });
            }
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger errorCode = [responseObject intValueForKey:@"result" defaultValue:-1];
            NSString *errorDomain = [responseObject stringValueForKey:@"message" defaultValue:@"请求失败"];
            NSError *error = [NSError errorWithDomain:errorDomain code:errorCode userInfo:nil];
            handler(error, nil, nil);
        });
    }
}

#pragma mark - config
- (NSString *)apiHostUrl {
    return [MDUtility sharedInstance].appBaseConfig.apiHostUrl;
}

- (NSDictionary *)configureCommonParams:(NSDictionary *)params {
    if ([params intValueForKey:kShouldIgnoreCommonParamsKey defaultValue:0] == 1) {
        return params;
    }

    if (params && [params isKindOfClass:[NSDictionary class]]) {
        params = [[MDUtility sharedInstance].appBaseAdaptor configCommonParams:params];
    }

    return params;
}

#pragma mark - debug
- (void)appendDebugRequestWithMethod:(NSString *)method apiPath:(NSString *)apiPath params:(NSDictionary *)params {
#if DEBUG
    NSMutableArray *allParams = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *pair = [NSString stringWithFormat:@"%@=%@", key, obj];
        [allParams addObject:pair];
    }];

    [self.debugQueue addObject:[NSString stringWithFormat:@"api path:%@ %@ params: %@", apiPath, method, [allParams componentsJoinedByString:@","]]];
#endif
}

- (void)outputDebugInfoAndClean {
    printf("\nrequest track\n~~~~~~~~~~~\n\n\n");

    for (NSString *info in self.debugQueue) {
        printf("\n\n%s\n\n", [info dataUsingEncoding:NSUTF8StringEncoding].bytes);
    }

    printf("\n~~~~~~~~~~~~");

    [self.debugQueue removeAllObjects];
}

@end
