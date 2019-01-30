//
//  MDCollectionViewCell.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "MDCollectionViewCell.h"

@implementation MDCollectionViewCell

+ (CGSize)cellSizeForCellDataObj:(id)cellDataObj; {
    return CGSizeMake(0, 0);
}

- (void)setCellDataObj:(id)cellDataObj {
    id originData = _cellDataObj;
    _cellDataObj = cellDataObj;
    
    if ([self shouldUpdateUIWithOriginCellData:originData newsetCellData:cellDataObj]) {
        [self updateUI];
    }
}

- (BOOL)shouldUpdateUIWithOriginCellData:(id)originDataObj newsetCellData:(id)newsetCellData {
    return YES;
}

- (void)updateUI {
    
}

@end
