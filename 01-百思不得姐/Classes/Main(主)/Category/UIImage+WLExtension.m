//
//  UIImage+WLExtension.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/9.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "UIImage+WLExtension.h"

@implementation UIImage (WLExtension)

- (instancetype)circleImage
{
    
    //开启图片 上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //获得 当前 上下文
    CGContextRef ctf = UIGraphicsGetCurrentContext();
    
    //画圆 裁剪
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctf, rect);
    CGContextClip(ctf);
    
    //添加图片
    [self drawInRect:rect];
    //获得 图片 上下文
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭 图片 上下文
    UIGraphicsEndImageContext();
    
    
    
    return image;
}

@end
