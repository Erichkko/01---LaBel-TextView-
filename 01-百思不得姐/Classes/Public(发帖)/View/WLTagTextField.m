//
//  WLTagTextField.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/13.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTagTextField.h"

@implementation WLTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.height = tagHeight;
        self.font = WLTagFont;
        self.backgroundColor = [UIColor yellowColor];//_placeholderLabel.textColor
        self.placeholder =@"多个标签用逗号或者换行隔开"; //_placeholderLabel.textColor
//       [self setValue:[UIColor blackColor] forKey:@"_placeholderLabel.textColor"];
    }
    return self;
}
-(void)insertText:(NSString *)text
{
    [super insertText:text];
    
    WLLog(@"%@",text);
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.height = tagHeight;
}
- (void)deleteBackward
{
   
    self.deleteBackLetter == nil?:self.deleteBackLetter();
    [super deleteBackward];
    WLLog(@"---");
   
}
@end
