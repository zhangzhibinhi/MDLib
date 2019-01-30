//
//  MDAdaptor.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/30.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MDAdaptor <NSObject>

+ (void)defaultAdaptor;

- (NSDictionary *)configCommonParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
