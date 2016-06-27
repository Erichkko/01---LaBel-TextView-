//
//  NSDate+Extension.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/26.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSDateComponents *)delDateFrom:(NSDate *)from
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
   NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    
   NSDateComponents *cmps = [calendar components:unit fromDate:from toDate:self options:kNilOptions];
    return cmps;
}

- (BOOL)isYear
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:now];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
    
}

- (BOOL)isMonth
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowMonth = [calendar component:NSCalendarUnitDay fromDate:now];
    NSInteger selfMonth = [calendar component:NSCalendarUnitDay fromDate:self];
    
    return ([self isYear])&&(nowMonth == selfMonth);
    
}

- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowDay = [calendar component:NSCalendarUnitDay fromDate:now];
    NSInteger selfDay = [calendar component:NSCalendarUnitDay fromDate:self];
    
    return ([self isMonth])&&(nowDay == selfDay);
    
}

- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *now = [NSDate date];
    
    NSString *nowString = [fmt stringFromDate:now];
    NSString *selfString = [fmt stringFromDate:self];
    
    NSDate *nowDate = [fmt dateFromString:nowString];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
//    NSTimeInterval deltaTime = [selfDate timeIntervalSinceDate:nowDate] ;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:kNilOptions];
    return cmps.year == 0&&cmps.month == 0&&cmps.day == 1;
    
}

- (BOOL)isMoment
{
    NSDate *date = [NSDate date];
    
    NSTimeInterval deltaTime = [date timeIntervalSinceDate:self];
    return deltaTime >= 0 && deltaTime <= 60 * 1000;
 }
@end
