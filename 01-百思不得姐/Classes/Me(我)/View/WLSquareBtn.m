//
//  WLSquareBtn.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/9.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLSquareBtn.h"
#import "WLSquare.h"
#import <UIButton+WebCache.h>
@implementation WLSquareBtn



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
    //调整图片
   
    self.imageView.y  = self.height * 0.1;
    self.imageView.width = self.width * 0.6;
    self.imageView.height = self.imageView.width;
     self.imageView.centerx = self.width * 0.5;
    
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame)+margin;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
   
    
}

- (void)setSquare:(WLSquare *)square
{
    _square =square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}
@end
