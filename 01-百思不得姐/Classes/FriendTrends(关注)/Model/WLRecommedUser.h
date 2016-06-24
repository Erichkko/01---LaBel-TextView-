//
//  WLRecommedUser.h
//  01-百思不得姐
//
//  Created by wanglong on 16/6/20.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLRecommedUser : NSObject
/**uid*/
@property(nonatomic,copy)NSString *uid;
/**fans_count*/
@property(nonatomic,copy)NSString *fans_count;
/**screen_name*/
@property(nonatomic,copy)NSString *screen_name;
/**header*/
@property(nonatomic,copy)NSString *header;
/**introduction*/
@property(nonatomic,copy)NSString *introduction;
/**tiezi_count*/
@property(nonatomic,assign)NSInteger tiezi_count;
/**is_follow*/
@property(nonatomic,assign)NSInteger is_follow;
/**gender*/
@property(nonatomic,assign)NSInteger gender;
@end
