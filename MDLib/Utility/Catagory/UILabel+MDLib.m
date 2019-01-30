//
//  UILabel+MDLib.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "UILabel+MDLib.h"

@implementation UILabel (MDLib)

- (void)alightLeftAndRightWithWidth:(CGFloat)labelWidth {
    [self layoutIfNeeded];
    CGSize testSize = [self.text boundingRectWithSize:CGSizeMake(labelWidth, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :self.font} context:nil].size;

    CGFloat margin = (labelWidth - testSize.width)/(self.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.text];

    [attribute addAttribute: NSKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1 )];
    self.attributedText = attribute;
}

@end
