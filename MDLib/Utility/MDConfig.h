//
//  MDConfig.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MDConfig <NSObject>

+ (void)defaultConfig;

@property (readonly, nonatomic) NSString *buglyID;
@property (readonly, nonatomic) NSString *gtAppID;
@property (readonly, nonatomic) NSString *gtAppKey;
@property (readonly, nonatomic) NSString *gtAppSecret;

@property (readonly, nonatomic) NSString *apiHostUrl;
@property (readonly, nonatomic) NSString *privateKey;
@property (readonly, nonatomic) NSString *privateIv;

@end

NS_ASSUME_NONNULL_END
