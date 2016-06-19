//
//  UIBarButtonItem+WLExtension.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "UIBarButtonItem+WLExtension.h"

@implementation UIBarButtonItem (WLExtension)

+ (instancetype)itemWithViewContoller:(UIViewController *)vc normalImage:(NSString *)norImage highImage:(NSString *)highImage action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}


@end
