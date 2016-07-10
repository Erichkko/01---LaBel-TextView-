//
//  WLTopWindow.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/6.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTopWindow.h"
#import "WLTopViewController.h"

@implementation WLTopWindow

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
//    window_.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    window_.backgroundColor = [UIColor clearColor];
    window_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    window_.windowLevel = UIWindowLevelAlert;
    
    WLTopViewController *topVc = [[WLTopViewController alloc] init];
    window_.rootViewController = topVc;
}
+ (void)show
{
    window_.hidden = NO;
}
@end
