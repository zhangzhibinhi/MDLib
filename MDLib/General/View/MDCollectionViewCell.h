//
//  MDCollectionViewCell.h
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) id cellDataObj;

@property (strong, nonatomic) NSIndexPath *itemIndexPath;

+ (CGSize)cellSizeForCellDataObj:(id)cellDataObj;

// for sub class
- (BOOL)shouldUpdateUIWithOriginCellData:(id)originDataObj newsetCellData:(id)newsetCellData; // 默认返回YES
- (void)updateUI;

@end
