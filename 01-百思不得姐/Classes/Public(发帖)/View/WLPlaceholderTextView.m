//
//  WLPlaceholderTextView.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/10.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLPlaceholderTextView.h"

@interface WLPlaceholderTextView ()

/** placeholderLabel */
@property(nonatomic,weak)UILabel *placeholderLabel;

@end
@implementation WLPlaceholderTextView


- (UILabel *)placeholderLabel
{
    if (_placeholderLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.x = 3;
        label.y = 8;
        label.numberOfLines = 0;
        label.width = WLWindow.size.width - 6;

        label.textColor = self.placeholderColor;
        label.text = self.placeholder;
        label.font = self.font;
        [self addSubview:label];
        _placeholderLabel = label;
        
    }
    return _placeholderLabel;
}
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
    self.alwaysBounceVertical = YES;
    
}

- (void)textViewChange:(NSNotification *)note
{
  self.placeholderLabel.hidden = self.hasText;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font =font;
     [self setNeedsLayout];
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    self.placeholderLabel.text = text;
    [self textViewChange:nil];
}
- (void)setAttributedText:(NSAttributedString *)attributedText

{
    [super setAttributedText:attributedText];
    [self textViewChange:nil];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.width = self.width  - 2 * self.placeholderLabel.x ;
    [self.placeholderLabel sizeToFit];
}


 //setNeedDisplay会在 恰当的时候调用drawrect方法
 //setNeedLayout会在 恰当的时候调用layoutSubView的方法
 //layIfNeed 强制刷新
//此方法 不严谨
- (void)updatePlaceholderSize
{
  
    
    //方法1计算宽度高度
//    CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(self.width - 6, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
//    WLLog(@"size  -- %@",NSStringFromCGSize(size));
//    self.placeholderLabel.size = size;

    
    //方法2 sizeToFit
    self.placeholderLabel.width = WLScreenW  - 6;
    [self.placeholderLabel sizeToFit];

}
///**
// *  每次调drawrect方法会清处 之前的绘制，再次进行重新绘制
// */
//- (void)drawRect:(CGRect)rect
//{
//    if (self.hasText) {
//        return;
//    }
//    rect.origin.x = 3;
//    rect.origin.y = 8;
//    rect.size.width -= 2 * rect.origin.x;
//    [self.placeholder drawInRect:rect withAttributes:@{
//                                                       NSForegroundColorAttributeName:self.placeholderColor,
//                                                       NSFontAttributeName:self.font
//                                                      }];
//}

- (void)dealloc
{
    [WLNoteCenter removeObserver:self];
}

@end
