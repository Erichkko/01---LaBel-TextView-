//
//  WLPlaceholderTextView.h
//  01-百思不得姐
//
//  Created by wanglong on 16/7/10.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLPlaceholderTextView : UITextView
/**placeholder*/
@property(nonatomic,copy)NSString *placeholder;
/**placeholderColor*/
@property(nonatomic,strong)UIColor *placeholderColor;
@end
