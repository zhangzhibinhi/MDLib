//
//  NSURLSessionTask+MDLib.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/30.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ApiCompleteHandler)(NSError *error, id resultData, id pharsedData);

NS_ASSUME_NONNULL_BEGIN

@interface NSURLSessionTask (MDLib)

- (ApiCompleteHandler)getUICallback;
- (void)setUICallback:(ApiCompleteHandler)handler;

@end

NS_ASSUME_NONNULL_END
