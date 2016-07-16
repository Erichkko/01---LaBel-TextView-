//
//  UIView+WLExtension.h
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WLExtension)
/**size*/
@property(nonatomic,assign)CGSize size;
/**width*/
@property(nonatomic,assign)CGFloat width;
/**height*/
@property(nonatomic,assign)CGFloat height;
/**x*/
@property(nonatomic,assign)CGFloat x;
/**y*/
@property(nonatomic,assign)CGFloat y;
/** centerx */
@property(nonatomic,assign)CGFloat centerx;
/** centery */
@property(nonatomic,assign)CGFloat centery;

-(BOOL) isShowingOnKeyWindow;

+ (instancetype)viewFromXib;
@end
