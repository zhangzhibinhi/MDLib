//
//  MDBaseAppDelegate.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDBaseAppDelegate : UIResponder<UIApplicationDelegate>

+ (instancetype)sharedAppDelegate;

- (void)enterMainController;
- (void)enterLoginController;

@end

NS_ASSUME_NONNULL_END
