//
//  NSString+MDLib.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSString+MDLib.h"

@implementation NSString (MDLib)

- (NSString *)MD5String {
    if(self == nil || [self length] == 0)
        return nil;

    const char *value = [self UTF8String];

    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);

    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }

    return outputString;
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)URLEncodedString {
    NSString *result = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return result;
}

- (NSString*)URLDecodedString {
    NSString *result = [self stringByRemovingPercentEncoding];
    //    NSString *resultWithoutPlus = [result stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return result;
}

- (BOOL)isValidEmail {
    if (self.length <= 5) {
        // x@x.cn
        return NO;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidIdentityCardNumber {
    NSString *userID = [self copy];
    //长度不为18的都排除掉
    if (userID.length != 18) {
        return NO;
    }

    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}"
    @"[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)"
    @"$";
    NSPredicate *identityCardPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];

    if (!flag) {
        return flag; //格式错误
    } else {
        //格式正确在判断是否合法

        //将前17位加权因子保存在数组里
        NSArray *idCardWiArray = @[
                                   @"7",
                                   @"9",
                                   @"10",
                                   @"5",
                                   @"8",
                                   @"4",
                                   @"2",
                                   @"1",
                                   @"6",
                                   @"3",
                                   @"7",
                                   @"9",
                                   @"10",
                                   @"5",
                                   @"8",
                                   @"4",
                                   @"2"
                                   ];

        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray *idCardYArray =
        @[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ];

        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for (int i = 0; i < 17; i++) {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];

            idCardWiSum += subStrIndex * idCardWiIndex;
        }

        //计算出校验码所在数组的位置
        NSInteger idCardMod = idCardWiSum % 11;

        //得到最后一位身份证号码
        NSString *idCardLast = [userID substringWithRange:NSMakeRange(17, 1)];

        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if (idCardMod == 2) {
            if ([idCardLast isEqualToString:@"X"] || [idCardLast isEqualToString:@"x"]) {
                return YES;
            } else {
                return NO;
            }
        } else {
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if ([idCardLast isEqualToString:[idCardYArray objectAtIndex:idCardMod]]) {
                return YES;
            } else {
                return NO;
            }
        }
    }
}

- (BOOL)isValidAge {
    return [self integerValue] >= 1 && [self integerValue] <= 130;
}

@end
