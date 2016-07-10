//
//  UIImageView+WLExtension.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/9.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "UIImageView+WLExtension.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (WLExtension)
-(void)setCircleHeaderWithURL:(NSString *)urlStr
{
    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr]placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image  = image?[image circleImage]:placeholderImage;
    }];
}
@end
