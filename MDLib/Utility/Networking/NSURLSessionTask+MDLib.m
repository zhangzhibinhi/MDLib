//
//  NSURLSessionTask+MDLib.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/30.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "NSURLSessionTask+MDLib.h"
#import <objc/runtime.h>

static const NSString *kUICallbackKey = @"MD_UI_CALLBACK";

@implementation NSURLSessionTask (MDLib)

- (ApiCompleteHandler)getUICallback {
    return objc_getAssociatedObject(self, (__bridge const void *)(kUICallbackKey));
}

- (void)setUICallback:(ApiCompleteHandler)handler {
    objc_setAssociatedObject(self,
                             (__bridge const void *)(kUICallbackKey),
                             handler,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
