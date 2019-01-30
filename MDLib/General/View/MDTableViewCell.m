//
//  MDTableViewCell.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "MDTableViewCell.h"

@implementation MDTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setCellDataObj:(id)cellDataObj {
    id originData = _cellDataObj;
    _cellDataObj = cellDataObj;
    
    if ([self shouldUpdateUIWithOriginCellData:originData newsetCellData:cellDataObj]) {
        [self updateUI];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
}

+ (CGFloat)cellHeightForDataObj:(id)celldataObj {
    return 0;
}

- (BOOL)shouldUpdateUIWithOriginCellData:(id)originDataObj newsetCellData:(id)newsetCellData {
    return YES;
}

- (void)updateUI {
    
}

@end
