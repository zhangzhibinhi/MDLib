//
//  MDUtility.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDConfig.h"
#import "MDAdaptor.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDUtility : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign) id<MDConfig> appBaseConfig;
@property (nonatomic, assign) id<MDAdaptor> appBaseAdaptor;
@property (nonatomic, weak) UINavigationController *currentNavigationController;
@property (nonatomic, weak) UIViewController *currentTopViewController;

- (void)setupPageMap;
- (void)hook;

@end

NS_ASSUME_NONNULL_END
