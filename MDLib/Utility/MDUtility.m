//
//  MDUtility.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "MDUtility.h"
#import <Aspects/Aspects.h>
#import "MDBaseViewController.h"
#import "MDPageManager.h"

@implementation MDUtility

+ (instancetype)sharedInstance {
    static id _s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _s_instance = [self new];
    });
    return _s_instance;
}

- (void)setupPageMap {
    [MDPageMap.defaultMap appendPageUrl:@"pageUrl" withPageClassString:@"classString" openType:PageOpenTypePush cacheType:PageCacheTypeNormal];
}

- (void)hook {
    NSError *error = nil;
    // UIViewController navigation
    [UIViewController aspect_hookSelector:@selector(prepareForSegue:sender:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo){
                                   NSArray *arguments = [aspectInfo arguments];
                                   if (arguments.count > 1) {
                                       UIStoryboardSegue *segue = arguments[0];
                                       id sender = arguments[1];

                                       if ([segue isKindOfClass:[UIStoryboardSegue class]] &&
                                           [sender isKindOfClass:[NSDictionary class]]) {
                                           if ([segue.destinationViewController isKindOfClass:[MDBaseViewController class]]) {
                                               [(MDBaseViewController *)segue.destinationViewController setupQueryData:sender];
                                           }
                                       }
                                   }
                               }
                                    error:&error];

    if (error) {
        NSLog(@"aspect_hookSelector:@selector(prepareForSegue:sender:)- error with %@", error);
    }

    error = nil;
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> aspectInfo){
                                   UIViewController *vc = [aspectInfo instance];
                                   if (vc.navigationController != nil) {
                                       self.currentNavigationController = vc.navigationController;
                                   }
                               }
                                    error:&error];

    if (error) {
        NSLog(@"aspect_hookSelector:@selector(viewWillAppear:)- error with %@", error);
    }
}

@end
