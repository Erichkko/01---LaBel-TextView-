//
//  WLLoginTool.h
//  01-百思不得姐
//
//  Created by wanglong on 16/7/16.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLLoginTool : NSObject
/**
 获取用户的Uid
 */
+(NSString *)getUid;
/**
 *  保存用户的uid
 */
+(void)setUid:(NSString *)uid;

+(void)checkIsLogin;
@end
