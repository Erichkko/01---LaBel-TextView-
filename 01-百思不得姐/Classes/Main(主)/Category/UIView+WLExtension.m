//
//  UIView+WLExtension.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "UIView+WLExtension.h"

@implementation UIView (WLExtension)

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}
- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}


- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
    
}

- (void)setCenterx:(CGFloat)centerx
{
    CGPoint center = self.center;
    center.x = centerx;
    self.center = center;
}
- (void)setCentery:(CGFloat)centery
{
    CGPoint center = self.center;
    center.y = centery;
    self.center = center;
}

- (CGFloat)centerx
{
   return self.center.x;
}

- (CGFloat)centery
{
    return self.center.y;
}

- (BOOL)isShowingOnKeyWindow
{
    CGRect newFrame = [self.superview convertRect:self.frame toView:WLWindow];
    CGRect windowFrame = WLWindow.bounds;
    return !self.isHidden && self.alpha >= 0.01 && self.window == WLWindow && CGRectContainsRect(newFrame,windowFrame);
    
}
@end
