//
//  MDTableViewCell.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDTableViewCell : UITableViewCell

@property (nonatomic, strong) id cellDataObj;

+ (CGFloat)cellHeightForDataObj:(id)celldataObj;

// for sub class
- (BOOL)shouldUpdateUIWithOriginCellData:(id)originDataObj newsetCellData:(id)newsetCellData; // 默认返回YES
- (void)updateUI;

@end
