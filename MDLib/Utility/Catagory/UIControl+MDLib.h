//
//  UIControl+MDLib.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^UIControlBlock)(UIControl *control);

@interface UIControl (MDLib)

- (void)addActionBlock:(UIControlBlock)actionBlock forControlEvents:(UIControlEvents)event;
- (void)setActionBlock:(UIControlBlock)actionBlock forControlEvents:(UIControlEvents)event;

@end

NS_ASSUME_NONNULL_END
