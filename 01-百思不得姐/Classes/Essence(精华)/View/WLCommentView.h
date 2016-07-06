//
//  WLComment.h
//  01-百思不得姐
//
//  Created by wanglong on 16/7/5.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLComment;
@interface WLCommentView : UITableViewCell
+ (instancetype)commentView;
/** comment */
@property(nonatomic,strong)WLComment *comment;
@end
