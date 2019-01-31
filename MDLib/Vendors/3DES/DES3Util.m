//
//  DES3Util.m
//  EAS
//
//  Created by ZHOUJIA on 14-3-24.
//  Copyright (c) 2014年 ZHOUJIA. All rights reserved.
//

#import "DES3Util.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>
#import "MDUtility.h"

@implementation DES3Util

#define gkey [MD]
#define gIv @"01234567"

// 加密方法
+ (NSString *)encrypt:(NSString *)plainText {
    NSData *data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];

    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;

    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);

    const void *vkey = (const void *)[[MDUtility sharedInstance].appBaseConfig.privateKey UTF8String];
    const void *vinitVec = (const void *)[[MDUtility sharedInstance].appBaseConfig.privateIv UTF8String];

    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);

    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    free(bufferPtr);
    NSString *result = [GTMBase64 stringByEncodingData:myData];
    return result;
}

// 解密方法
+ (NSString *)decrypt:(NSString *)encryptText {
    if ([encryptText isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    NSData *encryptData = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];

    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;

    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);

    const void *vkey = (const void *)[[MDUtility sharedInstance].appBaseConfig.privateKey UTF8String];
    const void *vinitVec = (const void *)[[MDUtility sharedInstance].appBaseConfig.privateIv UTF8String];

    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);

    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes]
                                             encoding:NSUTF8StringEncoding];
    free(bufferPtr);
    return result;
}

@end
