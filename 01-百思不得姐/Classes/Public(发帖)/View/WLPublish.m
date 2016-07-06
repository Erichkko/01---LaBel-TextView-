//
//  WLPublish.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/1.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLPublish.h"

@implementation WLPublish

- (void) setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
     [self setup];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat titleH = 30;
    self.imageView.frame = CGRectMake(0, 0, self.width, self.width);
    self.titleLabel.frame = CGRectMake(0, self.imageView.height + 10, self.width, titleH);
}

@end
