//
//  WLTopComment.h
//  01-百思不得姐
//
//  Created by wanglong on 16/7/3.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WLUser;
@interface WLTopComment : NSObject
/**content*/
@property(nonatomic,copy)NSString *content;
/**ctime*/
@property(nonatomic,copy)NSString *ctime;
/**like_count*/
@property(nonatomic,assign)NSInteger like_count;
/**voicetime*/
@property(nonatomic,assign)NSInteger voicetime;
/** user */
@property(nonatomic,strong)WLUser *user;
@end
