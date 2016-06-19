//
//  WLTabBar.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTabBar.h"

@interface WLTabBar ()
/** publishButton */
@property(nonatomic,strong)UIButton *publishButton ;

@end
@implementation WLTabBar

- (instancetype)initWithFrame:(CGRect)frame

{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        [self addSubview:_publishButton];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger subViewCount = self.subviews.count - 2;
    CGFloat vy = 0;
    CGFloat vw = self.width / subViewCount ;
    CGFloat vh = self.height ;
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width,  self.publishButton.currentBackgroundImage.size.height);
 
    
    NSInteger index = 0 ;
    for (UIView *view in self.subviews) {
        NSLog(@"index == %zd",index);
        if (![view isKindOfClass:NSClassFromString(@"UITabBarButton")])
            continue;
        NSInteger newIndex = index >1 ?index +1 :index;
        CGFloat vx  = vw * newIndex;
        view.frame = CGRectMake(vx, vy, vw, vh);
         index++;
    }
}

@end
