//
//  NSDate+Extension.h
//  01-百思不得姐
//
//  Created by wanglong on 16/6/26.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
-(NSDateComponents *)delDateFrom:(NSDate *)from;
- (BOOL) isYear;
- (BOOL) isToday;
- (BOOL) isYesterday;
- (BOOL) isMoment;
@end
