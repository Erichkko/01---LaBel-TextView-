//
//  WLComment.h
//  01-百思不得姐
//
//  Created by wanglong on 16/7/4.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WLUser;
@interface WLComment : NSObject
/** commentId */
@property(nonatomic,strong)NSString *commentId;
/**content*/
@property(nonatomic,copy)NSString *content;
/**voicetime*/
@property(nonatomic,assign)NSInteger voicetime;
/**voicetime*/
@property(nonatomic,copy)NSString *voiceuri;
/**ctime*/
@property(nonatomic,copy)NSString *ctime;
/**like_count*/
@property(nonatomic,assign)NSInteger like_count;
/** user */
@property(nonatomic,strong)WLUser *user;
@end
