//
//  WLAllComment.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/4.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLAllComment.h"
#import <MJExtension.h>

@implementation WLAllComment

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"data":@"WLComment",
             @"hot":@"WLComment"
             };
}
@end
