//
//  UIDevice+MDLib.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "UIDevice+MDLib.h"
#import <SAMKeychain/SAMKeychain.h>
#import "MDDefines.h"

@implementation UIDevice (MDLib)

+ (NSString *)token {
    NSString *token = [SAMKeychain passwordForService:APP_ID account:APP_ID];
    if (token && token.length) {
        return token;
    } else {
        token = [self getUUID];
        [SAMKeychain setPassword:token forService:APP_ID account:APP_ID];
        return token;
    }
}

+ (NSString *)getUUID {
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

@end
