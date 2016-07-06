//
//  WLVoice.h
//  01-百思不得姐
//
//  Created by wanglong on 16/7/2.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLTopic;
@interface WLVoice : UIView

/** topic */
@property(nonatomic,strong)WLTopic *topic;
+ (instancetype)voice;
@end
