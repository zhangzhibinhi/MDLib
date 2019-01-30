//
//  NSString+MDLib.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MDLib)

- (NSString *)MD5String;
- (NSString *)trim;
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

/// 邮箱校验
- (BOOL)isValidEmail;
/// 身份证号校验
- (BOOL)isValidIdentityCardNumber;
/// 年龄校验 1-130
- (BOOL)isValidAge;

@end

NS_ASSUME_NONNULL_END
