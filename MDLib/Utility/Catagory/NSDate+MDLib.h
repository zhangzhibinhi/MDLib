//
//  NSDate+MDLib.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (MDLib)

@property (readonly, nonatomic) NSInteger year;
@property (readonly, nonatomic) NSInteger month;
@property (readonly, nonatomic) NSInteger day;
@property (readonly, nonatomic) NSInteger hour;
@property (readonly, nonatomic) NSInteger minute;
@property (readonly, nonatomic) NSInteger second;

- (NSString *)yyyyMMddString;
- (NSString *)yyyyMMddHHmmssString;
- (NSString *)yyyyMMddHHmmString;
- (NSString *)HHmmString;
- (NSString *)HHmmssString;
- (NSString *)dateStringWithFormat:(NSString *)format;

- (NSDate *)previousYear;
- (NSDate *)nextYear;

@end

NS_ASSUME_NONNULL_END
