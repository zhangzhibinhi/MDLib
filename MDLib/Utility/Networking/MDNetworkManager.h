//
//  MDNetworkManager.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/30.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSURLSessionTask+MDLib.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDNetworkManager : NSObject

@property (readonly) BOOL isNetworkAviliable;

+ (instancetype)sharedManager;
+ (BOOL)hasNetwork;
- (void)startNetworkAviliableNotifier;

// get methods
- (NSURLSessionDataTask *)getRequestWithParams:(NSDictionary *)params
                     apiPath:(NSString *)apiPath
             completeHandler:(ApiCompleteHandler)handler;

// 更新v2.0: 支持自定义host url
- (NSURLSessionDataTask *)getWithParams:(NSDictionary *)params
           apiHostUrl:(NSString *)hostUrl
              apiPath:(NSString *)apiPath
      completeHandler:(ApiCompleteHandler)handler;

// post methods
- (NSURLSessionDataTask *)postRequestWithParams:(NSDictionary *)params
                      apiPath:(NSString *)apiPath
              completeHandler:(ApiCompleteHandler)handler;

// 更新v2.0: 支持自定义host url
- (NSURLSessionDataTask *)postRequestWithParams:(NSDictionary *)params
                   apiHostUrl:(NSString *)hostUrl
                      apiPath:(NSString *)apiPath
              completeHandler:(ApiCompleteHandler)handler;

// override for subclass
- (NSString *)apiHostUrl;

@end

NS_ASSUME_NONNULL_END
