//
//  NSDate+MDLib.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "NSDate+MDLib.h"

@implementation NSDate (MDLib)

- (NSInteger)year {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:self];
}

- (NSInteger)month {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:self];
}

- (NSInteger)day {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self];
}

- (NSInteger)hour {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:self];
}

- (NSInteger)minute {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:self];
}

- (NSInteger)second {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:self];
}

- (NSString *)yyyyMMddString {
    return [self dateStringWithFormat:@"yyyy-MM-dd"];
}

- (NSString *)yyyyMMddHHmmString {
    return [self dateStringWithFormat:@"yyyy-MM-dd HH:mm"];
}

- (NSString *)yyyyMMddHHmmssString {
    return [self dateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)HHmmString {
    return [self dateStringWithFormat:@"HH:mm"];
}

- (NSString *)HHmmssString {
    return [self dateStringWithFormat:@"HH:mm:ss"];
}

- (NSString *)dateStringWithFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:self];
}

- (NSDate *)previousYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear fromDate:self];
    [component setYear:-1];
    NSDate *date = [calendar dateByAddingComponents:component toDate:self options:0];
    return date;
}

- (NSDate *)nextYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear fromDate:self];
    [component setYear:1];
    NSDate *date = [calendar dateByAddingComponents:component toDate:self options:0];
    return date;
}

@end
