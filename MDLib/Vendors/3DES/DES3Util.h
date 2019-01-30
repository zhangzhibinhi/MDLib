//
//  DES3Util.h
//  EAS
//
//  Created by ZHOUJIA on 14-3-24.
//  Copyright (c) 2014年 ZHOUJIA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3Util : NSObject

// 加密方法
+ (NSString *)encrypt:(NSString *)plainText;

// 解密方法
+ (NSString *)decrypt:(NSString *)encryptText;

@end
