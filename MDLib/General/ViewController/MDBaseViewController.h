//
//  MDBaseViewController.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MDBaseViewControllerProtocol <NSObject>

@optional
/// step 1 : setup UI
- (void)setupUIElements;
/// step 2 : setup Notification & Observer
- (void)setupObservers;
/// step 3 : setup Data
- (void)setupData;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MDBaseViewController : UIViewController<MDBaseViewControllerProtocol>

@property (nonatomic, strong) NSDictionary *pageQueryData;
- (void)setupQueryData:(id)queryData;

/// 是否展示backItem
@property (assign, nonatomic) BOOL shouldShowBackItem;
/// back action
- (void)onBackAction:(id _Nonnull)sender;

/// 添加notifiation通知方法 便于统一移除
- (void)pi_addObserverForName:(nullable NSNotificationName)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (^_Nullable)(NSNotification * _Nullable note))block;

@end

NS_ASSUME_NONNULL_END
