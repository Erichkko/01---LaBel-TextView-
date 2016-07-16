//
//  WLTagButton.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/12.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTagButton.h"

@implementation WLTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = WLTAGColor;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.height = tagHeight;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state

{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3*tagMargin;
    self.height = tagHeight;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = tagMargin;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+tagMargin;
     self.height = tagHeight;
}
@end
