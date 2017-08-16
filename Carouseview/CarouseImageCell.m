//
//  CarouseImageCell.m
//  CarouselDemo
//
//  Created by liicon on 2017/8/2.
//  Copyright © 2017年 max. All rights reserved.
//

#import "CarouseImageCell.h"

@implementation CarouseImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.frame;
    CGFloat width = self.superview.frame.size.width;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
}

@end
