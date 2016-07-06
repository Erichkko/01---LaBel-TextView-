//
//  WLComment.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/4.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLComment.h"
#import <MJExtension.h>
@implementation WLComment


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"commentId":@"id"
             };
}
@end
