//
//  WLMeCell.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/9.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLMeCell.h"

@implementation WLMeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image ==nil) {
        return;
    }
    self.imageView.width = 36;
    self.imageView.height = 36;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + margin;
}
/**
 *  group类型的tableView的默认 会向下移动35的距离
    可以通过此方法解决
    还可以通过设置tableView的内边距contenInset来改变也可以
 *
 */
//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y -= (35 - margin);
//    [super setFrame:frame];
//}

@end
