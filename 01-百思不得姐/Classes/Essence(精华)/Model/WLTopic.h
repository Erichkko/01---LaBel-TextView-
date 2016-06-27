//
//  WLTopic.h
//  01-百思不得姐
//
//  Created by wanglong on 16/6/26.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLTopic : NSObject
/** name */
@property(nonatomic,strong)NSString *name;
/** profile_image */
@property(nonatomic,strong)NSString *profile_image;
/** create_time */
@property(nonatomic,strong)NSString *create_time;
/** text */
@property(nonatomic,strong)NSString *text;
/**ding*/
@property(nonatomic,assign)NSInteger ding;
/**cai*/
@property(nonatomic,assign)NSInteger cai;
/**repost*/
@property(nonatomic,assign)NSInteger repost;
/**comment*/
@property(nonatomic,assign)NSInteger comment;
/**sina_v*/
@property(nonatomic,assign)NSInteger sina_v;
@end
