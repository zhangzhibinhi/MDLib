//
//  MDPageManager.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDPageMap.h"

@interface MDPageManager : NSObject

+ (instancetype)defaultManager;
- (id)openUrl:(NSString *)url withQueryData:(NSDictionary *)queryData;

@end
