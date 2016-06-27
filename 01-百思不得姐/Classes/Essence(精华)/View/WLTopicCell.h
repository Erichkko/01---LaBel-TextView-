//
//  WLTopicCell.h
//  01-百思不得姐
//
//  Created by wanglong on 16/6/26.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLTopic;
@interface WLTopicCell : UITableViewCell

/** topic */
@property(nonatomic,strong)WLTopic *topic;

+(instancetype) topicCell;
@end
