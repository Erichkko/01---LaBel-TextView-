//
//  WLPlaceholderTextView.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/10.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLPlaceholderTextView.h"

@interface WLPlaceholderTextView ()

@end
@implementation WLPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.font = [UIFont systemFontOfSize:15];
    [WLNoteCenter addObserver:self selector:@selector(textViewChange:) name:UITextViewTextDidChangeNotification object:nil];
    self.placeholderColor = [UIColor grayColor];
    self.placeholder = @"请输入文字...";
}

- (void)textViewChange:(NSNotification *)note
{
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}
/**
 *  每次调drawrect方法会清处 之前的绘制，再次进行重新绘制
 */
- (void)drawRect:(CGRect)rect
{
    if (self.hasText) {
        return;
    }
    rect.origin.x = 3;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:@{
                                                       NSForegroundColorAttributeName:self.placeholderColor,
                                                       NSFontAttributeName:self.font
                                                      }];
}

- (void)dealloc
{
    [WLNoteCenter removeObserver:self];
}

@end
