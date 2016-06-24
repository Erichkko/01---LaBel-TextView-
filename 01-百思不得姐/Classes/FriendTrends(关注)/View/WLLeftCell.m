//
//  WLLeftCell.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/20.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLLeftCell.h"
#import "WLCategory.h"


@interface WLLeftCell()

@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end
@implementation WLLeftCell

- (void)awakeFromNib {
    self.backgroundColor = WLRGBColor(244, 244, 244);
    self.textLabel.textColor = WLRGBColor(78, 78, 78);
    self.textLabel.highlightedTextColor = WLRGBColor(255, 0, 0);
}


- (void)setCategory:(WLCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 1;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.indicatorView.hidden = !selected ;
    self.textLabel.textColor = selected?WLRGBColor(255, 0, 0):WLRGBColor(78, 78, 78);
}
@end
