//
//  WLTextField.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/25.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTextField.h"
#import <objc/runtime.h>
@implementation WLTextField



//方法1 重写drawPlaceholderInRect
// - (void)drawPlaceholderInRect:(CGRect)rect
//{
////    CGRect placeHolderRect = CGRectMake(0, 10, self.width,self.height);
////    [self.placeholder drawInRect:placeHolderRect withAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],
////        NSFontAttributeName:self.font}];
//}


//方法2 runtime (运行时机制)

- (void)awakeFromNib
{
    
    UILabel *placeHolderLabel = [self valueForKey:@"_placeholderLabel"];
    placeHolderLabel.textColor = [UIColor grayColor];
//    unsigned int count = 0;
//    Ivar *ivars =  class_copyIvarList([UITextField class], &count);
//    
//    for (int i = 0; i < count; i++) {
//        Ivar ivar = *(ivars + i);
//        WLLog(@"ivarName == %s", ivar_getName(ivar));
//    }
//    free(ivars);
    
}

- (BOOL)becomeFirstResponder
{
    UILabel *placeHolderLabel = [self valueForKey:@"_placeholderLabel"];
    placeHolderLabel.textColor = self.textColor;
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    UILabel *placeHolderLabel = [self valueForKey:@"_placeholderLabel"];
    placeHolderLabel.textColor = [UIColor grayColor];
    return [super resignFirstResponder];
}
@end
