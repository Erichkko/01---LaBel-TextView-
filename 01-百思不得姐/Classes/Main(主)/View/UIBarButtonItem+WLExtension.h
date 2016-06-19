//
//  UIBarButtonItem+WLExtension.h
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WLExtension)

+(instancetype) itemWithViewContoller:(UIViewController *)vc normalImage:(NSString *)norImage highImage:(NSString *)highImage action:(SEL)action;
@end
