//
//  WLTopViewController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/6.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTopViewController.h"

@interface WLTopViewController ()

@end

@implementation WLTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self searchScrollView:WLWindow];
}

- (void)searchScrollView:(UIView *)superView
{
    for (UIScrollView *subView in superView.subviews) {
    
    if ([subView isKindOfClass:[UIScrollView class]]&&subView.isShowingOnKeyWindow) {
        CGPoint offset = subView.contentOffset;
        offset.y = - subView.contentInset.top;
        [subView setContentOffset:offset animated:YES];
    }
        [self searchScrollView:subView];
    }
    
}

//- (BOOL)isShowingOnKeyWindow:(UIView *)view {
//
//    // 以主窗口左上角为坐标原点, 计算self的矩形框
//    CGRect newFrame = [WLWindow convertRect:view.frame fromView:view.superview];
//    CGRect winBounds = WLWindow.bounds;
//    // 主窗口的bounds 和 self的矩形框 是否有重叠
//    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
//    
//    return !view.isHidden && (view.alpha > 0.01) && view.window == WLWindow && intersects;
//}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}
@end
