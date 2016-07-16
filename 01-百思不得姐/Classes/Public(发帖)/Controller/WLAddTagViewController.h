//
//  WLAddTagViewController.h
//  01-百思不得姐
//
//  Created by wanglong on 16/7/10.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLAddTagViewController : UIViewController
/**returnBlock*/
@property(nonatomic,copy) void(^returnBlock)(NSArray *);
/** tags */
@property(nonatomic,strong)NSArray *tags;
@end
