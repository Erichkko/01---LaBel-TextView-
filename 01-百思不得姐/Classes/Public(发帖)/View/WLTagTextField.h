//
//  WLTagTextField.h
//  01-百思不得姐
//
//  Created by wanglong on 16/7/13.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface WLTagTextField : UITextField
/**DeleteBackLetter*/
@property(nonatomic,copy) void(^deleteBackLetter)();
@end
