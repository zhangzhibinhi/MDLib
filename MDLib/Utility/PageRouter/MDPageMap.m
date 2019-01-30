//
//  MDPageMap.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "MDPageMap.h"
#import "NSDictionary+MDLib.h"

@interface MDPageMap ()

@property (nonatomic, strong) NSMutableDictionary *pageCacheDic;

@end

@implementation MDPageMap

+ (instancetype)defaultMap {
    static id _s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _s_instance = [self new];
    });
    return _s_instance;
}

- (void)appendPageUrl:(NSString *)pageUrl withPageInfoObj:(MDPageMetaInfo *)pageInfoObj {
    if (pageUrl.length > 0 && [pageInfoObj isKindOfClass:[MDPageMetaInfo class]]) {
        [self.pageCacheDic setObject:pageInfoObj forKey:pageUrl];
    }
}

- (MDPageMetaInfo *)pageMetaInfoForPageUrl:(NSString *)pageUrl {
    if (pageUrl.length > 0) {
        return [self.pageCacheDic objectForKey:pageUrl ofClass:[MDPageMetaInfo class] defaultObj:nil];
    }
    return nil;
}

/// setup controller create from code
- (MDPageMetaInfo *)appendPageUrl:(NSString *)pageUrl withPageClassString:(NSString *)classString openType:(PageOpenType)openType cacheType:(PageCacheType)cacheType {
    if (pageUrl.length > 0 && classString.length > 0) {
        
        MDPageMetaInfo *pageObj = [MDPageMetaInfo new];
        pageObj.pageUrlString = pageUrl;
        pageObj.pageClassNameString = classString;
        pageObj.openType = openType;
        pageObj.cacheType = cacheType;
        pageObj.sourceType = PageSourceTypeCode;
        pageObj.animated = YES;
        
        [self appendPageUrl:pageUrl withPageInfoObj:pageObj];
        
        return pageObj;
    }
    return nil;
}

/// setup controller create from nib
- (MDPageMetaInfo *)appendPageUrl:(NSString *)pageUrl withNibName:(NSString *)nibName pageClassString:(NSString *)classString openType:(PageOpenType)openType cacheType:(PageCacheType)cacheType {
    if (pageUrl.length > 0 && nibName.length > 0) {
        
        MDPageMetaInfo *pageObj = [MDPageMetaInfo new];
        pageObj.pageUrlString = pageUrl;
        pageObj.pageNibName = nibName;
        pageObj.pageClassNameString = classString;
        pageObj.openType = openType;
        pageObj.cacheType = cacheType;
        pageObj.sourceType = PageSourceTypeNib;
        pageObj.animated = YES;
        
        [self appendPageUrl:pageUrl withPageInfoObj:pageObj];
        
        return pageObj;
    }
    return nil;
}

/// setup controller create from storyboard
- (MDPageMetaInfo *)appendPageUrl:(NSString *)pageUrl withStoryboardName:(NSString *)storyboardName idString:(NSString *)idString openType:(PageOpenType)openType cacheType:(PageCacheType)cacheType {
    
    if (pageUrl.length > 0 && idString.length > 0) {
        
        MDPageMetaInfo *pageObj = [MDPageMetaInfo new];
        pageObj.pageUrlString = pageUrl;
        pageObj.pageStoryboardName = storyboardName;
        pageObj.identifier = idString;
        pageObj.openType = openType;
        pageObj.cacheType = cacheType;
        pageObj.sourceType = PageSourceTypeStoryboard;
        pageObj.animated = YES;
        
        [self appendPageUrl:pageUrl withPageInfoObj:pageObj];
        
        return pageObj;
    }
    return nil;
}

#pragma mark - properties
- (NSMutableDictionary *)pageCacheDic {
    if (!_pageCacheDic) {
        _pageCacheDic = [[NSMutableDictionary alloc] init];
    }
    return _pageCacheDic;
}

@end
