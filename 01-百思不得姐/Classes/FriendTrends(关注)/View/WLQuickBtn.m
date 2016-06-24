//
//  WLQuickBtn.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/24.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLQuickBtn.h"

@implementation WLQuickBtn

- (void)setup
{
    self.titleLabel.textAlignment =NSTextAlignmentCenter;
    
}
- (void)awakeFromNib
{
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
//    CGFloat imageW = 70;
//    CGFloat imageH = 70;
//    CGFloat imageX = 0;
//    CGFloat imageY = 0;
//    CGFloat titleW = 70;
//    CGFloat titleH = 20;
//    CGFloat titleX = 0;
//    CGFloat titleY = imageH;
//    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
//    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //image
    self.imageView.width = self.width;
    self.imageView.height = self.width;
    self.imageView.x  = 0;
    self.imageView.y = 0;
    //text
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width =self.width;
    self.titleLabel.height = self.height -self.imageView.height;
    
  
}
@end
