//
//  WLTopic.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/26.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTopic.h"

@implementation WLTopic
- (NSString *)create_time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *formatDate = [fmt dateFromString:_create_time];
    NSString  *dateString = nil;
    
    if (formatDate.isYear) {
        if (formatDate.isToday) {
            NSDateComponents *cmps = [[NSDate date] delDateFrom:formatDate];
            if (cmps.hour > 0) {
                fmt.dateFormat = @"HH小时之前";
                dateString = [NSString stringWithFormat:@"%zd小时之前",cmps.hour];
            }else if(cmps.minute > 0){
                fmt.dateFormat = @"mm分钟之前";
                dateString = [NSString stringWithFormat:@"%zd分钟之前",cmps.minute];
            }else{
                fmt.dateFormat = @"刚刚";
                dateString = [fmt stringFromDate:formatDate];
            }
            
            
        }else if (formatDate.isYesterday){
            fmt.dateFormat = @"昨天 HH:mm:ss";
            dateString = [fmt stringFromDate:formatDate];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            dateString = [fmt stringFromDate:formatDate];
        }
    } else{
        dateString = _create_time;
    }
    return dateString;
}
@end
