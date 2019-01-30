//
//  MDBaseAppDelegate.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "MDBaseAppDelegate.h"
#import <Bugly/Bugly.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "MDBaseAppDelegate+MDPush.h"
#import "MDDefines.h"
#import "UIDevice+MDLib.h"
#import "MDUtility.h"

static MDBaseAppDelegate *sharedAppDelegate = nil;

@implementation MDBaseAppDelegate

+ (instancetype)sharedAppDelegate {
    return sharedAppDelegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    sharedAppDelegate = self;
    [self setupCommonConfig];
    [[MDUtility sharedInstance] hook];
    
    return YES;
}

- (void)setupCommonConfig {
    // 优先初始化bugly，防止App初始化崩溃
    [self setupBuglyConfig];
    // 初始化推送的相关配置
    [self setupPushConfig];
}

- (void)setupBuglyConfig {
    BuglyConfig *buglyConfig = [BuglyConfig new];
#ifdef DEBUG
    buglyConfig.debugMode = YES;
#else
    buglyConfig.debugMode = NO;
#endif
    buglyConfig.channel = @"AppStore";
    buglyConfig.version = APP_VERSION;
    buglyConfig.deviceIdentifier = DEVICE_TOKEN;
    buglyConfig.unexpectedTerminatingDetectionEnable = YES;
    buglyConfig.viewControllerTrackingEnable = YES;
    buglyConfig.reportLogLevel = BuglyLogLevelVerbose;
    [Bugly startWithAppId:[MDUtility sharedInstance].appBaseConfig.buglyID config:buglyConfig];
}

- (void)enterMainController {
    // override
    // self.window.rootViewController = [MainViewController new];
}

- (void)enterLoginController {
    // override
    // self.window.rootViewController = [LoginViewController new];
}

@end
