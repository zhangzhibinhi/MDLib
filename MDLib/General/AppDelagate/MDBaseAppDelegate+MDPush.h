//
//  MDBaseAppDelegate+MDPush.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "MDBaseAppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDBaseAppDelegate (MDPush)

- (void)setupPushConfig;
- (void)registerRemoteNotification;

@end

NS_ASSUME_NONNULL_END
