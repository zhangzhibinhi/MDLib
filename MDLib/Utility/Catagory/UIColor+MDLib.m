//
//  UIColor+MDLib.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "UIColor+MDLib.h"
#import "MDDefines.h"

@implementation UIColor (MDLib)

+ (instancetype)hexColor:(NSString *)hexColor {
    if ([hexColor length] < 6) {
        return nil;
    }
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red / 255.f) green:(float)(green / 255.f) blue:(float)(blue / 255.f) alpha:1.f];
}

+ (instancetype)colorWithHex:(int)hex {
    return UIColorFromRGB(hex);
}

@end
