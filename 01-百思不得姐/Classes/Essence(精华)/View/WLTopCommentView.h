//
//  WLTopCommentView.h
//  01-百思不得姐
//
//  Created by wanglong on 16/7/3.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLTopComment;
@interface WLTopCommentView : UIView

+ (instancetype)commentView;
/** comment */
@property(nonatomic,strong)WLTopComment *topComment;
@end
