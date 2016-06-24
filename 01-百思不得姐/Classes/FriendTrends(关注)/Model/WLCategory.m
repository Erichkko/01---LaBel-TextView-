//
//  WLCategory.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/20.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLCategory.h"

@implementation WLCategory
- (NSMutableArray *)users
{
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
