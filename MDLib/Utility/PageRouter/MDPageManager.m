//
//  MDPageManager.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDPageManager.h"
#import "MDBaseViewController.h"
#import "MDDefines.h"
#import "MDUtility.h"

@interface MDPageManager ()

@property (nonatomic, strong) MDPageMap *pageMap;

@end

@implementation MDPageManager

+ (instancetype)defaultManager {
    static id _s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _s_instance = [self new];
    });
    return _s_instance;
}

- (id)openUrl:(NSString *)url withQueryData:(NSDictionary *)queryData {
    if (url.length > 0) {
        MDPageMetaInfo *pageObj = [self.pageMap pageMetaInfoForPageUrl:url];
        if (pageObj) {
            UIViewController *controller = nil;
            
            // load cache if needed
            if (pageObj.cacheType == PageCacheTypeShared) {
                controller = [pageObj.cachedPageInstance isKindOfClass:[UIViewController class]] ? pageObj.cachedPageInstance : nil;
                
                // 防止共享的已经展示了的controller重复打开导致问题
                if (controller.parentViewController || controller.presentingViewController) {
                    return nil;
                }
                
                // 如果controller加载过，view还在内存中，在打开时需要释放view 保证controller会重新调用viewDidLoad
                if (controller &&
                    controller.isViewLoaded) {
                    [controller.view removeFromSuperview];
                    controller.view = nil;
                }
            }
            
            if (!controller) {
                controller = [self generateControllerFromPageObj:pageObj];
            }
            
            if ([controller isKindOfClass:[MDBaseViewController class]]) {
                [(MDBaseViewController *)controller setupQueryData:queryData];
            }
            
            if (controller) {
                if (pageObj.openType == PageOpenTypeModal) {
                    
                    if (pageObj.shouldContainController) {
                        if (![controller isKindOfClass:[UINavigationController class]]) {
                            controller = [[UINavigationController alloc] initWithRootViewController:controller];
                        }
                    }
                    
                    [[MDUtility sharedInstance].currentNavigationController presentViewController:controller animated:pageObj.animated completion:nil];
                    
                } else if (pageObj.openType == PageOpenTypePush) {
                    
                    if (![controller isKindOfClass:[UINavigationController class]]) {
                        [[MDUtility sharedInstance].currentNavigationController pushViewController:controller animated:pageObj.animated];
                        
                        [MDUtility sharedInstance].currentNavigationController.interactivePopGestureRecognizer.delegate = nil;
                    }
                }
            }
            
            return controller;
        }
    }
    return nil;
}

#pragma mark - properties
- (MDPageMap *)pageMap {
    if (!_pageMap) {
        _pageMap = [MDPageMap defaultMap];
    }
    return _pageMap;
}

#pragma mark - private
- (UIViewController *)generateControllerFromPageObj:(MDPageMetaInfo *)pageObj {
    if (pageObj && [pageObj isKindOfClass:[MDPageMetaInfo class]]) {
        UIViewController *controller = nil;
        
        if (pageObj.sourceType == PageSourceTypeCode) {
            if (pageObj.pageClassNameString.length > 0) {
                controller = [[NSClassFromString(pageObj.pageClassNameString) alloc] init];
            }
        } else if (pageObj.sourceType == PageSourceTypeNib) {
            if (pageObj.pageNibName.length > 0 && pageObj.pageClassNameString.length > 0 && [NSClassFromString(pageObj.pageClassNameString) isSubclassOfClass:[UIViewController class]]) {
                controller = [[NSClassFromString(pageObj.pageClassNameString) alloc] initWithNibName:pageObj.pageNibName bundle:nil];
            }
        } else if (pageObj.sourceType == PageSourceTypeStoryboard) {
            if (pageObj.identifier.length > 0) {
                UIStoryboard *sb = pageObj.pageStoryboardName.length > 0 ? [UIStoryboard storyboardWithName:pageObj.pageStoryboardName bundle:nil] : [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                controller = [sb instantiateViewControllerWithIdentifier:pageObj.identifier];
            }
        }
        
        if (pageObj.cacheType == PageCacheTypeShared) {
            pageObj.cachedPageInstance = controller;
        }
        
        return controller;
    }
    return nil;
}

@end
