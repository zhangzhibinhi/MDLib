//
//  MDPageMap.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDPageMetaInfo.h"

@interface MDPageMap : NSObject

+ (instancetype)defaultMap;
- (void)appendPageUrl:(NSString *)pageUrl withPageInfoObj:(MDPageMetaInfo *)pageInfoObj;
- (MDPageMetaInfo *)pageMetaInfoForPageUrl:(NSString *)pageUrl;

/// setup controller create from code
- (MDPageMetaInfo *)appendPageUrl:(NSString *)pageUrl withPageClassString:(NSString *)classString openType:(PageOpenType)openType cacheType:(PageCacheType)cacheType;

/// setup controller create from nib
- (MDPageMetaInfo *)appendPageUrl:(NSString *)pageUrl withNibName:(NSString *)nibName pageClassString:(NSString *)classString openType:(PageOpenType)openType cacheType:(PageCacheType)cacheType;

/// setup controller create from storyboard
- (MDPageMetaInfo *)appendPageUrl:(NSString *)pageUrl withStoryboardName:(NSString *)storyboardName idString:(NSString *)idString openType:(PageOpenType)openType cacheType:(PageCacheType)cacheType;

@end
