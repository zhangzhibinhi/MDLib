//
//  MDDefines.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#ifndef MDDefines_h
#define MDDefines_h

/* ================================ System ================================ */
#pragma mark - System

#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) ((void)0)
#endif

#define WEAK_SELF_DEFINE(weakSelf) __weak typeof(self) (weakSelf) = self

#ifndef USERDEFAULTS
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]
#endif

#ifndef NOTIFICATION_CENTER
#define NOTIFICATION_CENTER [NSNotificationCenter defaultCenter]
#endif

#define NIB_FOR_NAME(nibName) [UINib nibWithNibName:nibName bundle:nil]
#define STRING_FROM_CLASS(aClass)  NSStringFromClass([aClass class])

/* ============================== System End ============================== */

/* ================================ Device ================================ */
#pragma mark - Device

#ifndef IS_IPHONE
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#endif

#ifndef IS_PAD
#define IS_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#endif

#ifndef SYSTEM_VERSION
#define SYSTEM_VERSION ([[UIDevice currentDevice] systemVersion])
#endif

#ifndef DEVICE_NAME
#define DEVICE_NAME ([UIDevice devicePlatformString])
#endif

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#endif

#ifndef DEVICE_TOKEN
#define DEVICE_TOKEN [UIDevice token]
#endif

/* ============================== Device End ============================== */

/* ================================ App ================================ */
#pragma mark - App

#define APP_ID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
/// DisplayName
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
/// ShortVersionString
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/// Build Version
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/* ============================== App End ============================== */

/* ================================ Color ================================ */
#pragma mark - Color

#define RGBColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
#define UIColorFromRGB_a(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:(a)]
#define RANDOMCOLOR RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

/* ============================== Color End ============================== */

#endif /* MDDefines_h */
