//
//  WLTopic.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/26.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTopic.h"
#import <MJExtension.h>
#import "WLPIcture.h"
#import "WLTopComment.h"
#import "WLUser.h"
@interface WLTopic ()
{
    CGFloat _cellHeight;
}

@end
@implementation WLTopic

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
              @"smallImage":@"image0",
              @"largeImage":@"image1",
              @"middleImage":@"image2",
              @"topicId":@"id"
             };
}


+ (NSDictionary *) mj_objectClassInArray
{
    return @{
             @"top_cmt":[WLTopComment class]
             
             };
}
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


- (CGFloat)cellHeight
{
    
    if (_cellHeight == 0) {
        
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * margin, MAXFLOAT);
        CGFloat contentH  = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:WLCellFont} context:nil].size.height;
        
        _cellHeight =  contentY + contentH +  margin;
        if (self.type == WLTopicTypePicture) {
            CGFloat picW = maxSize.width ;
            CGFloat picH = picW * (self.height / self.width);
            
            if (picH >cellPictureMaxH) {
                picH = cellPictureBreakH;
                _bigPicture = YES;
            }else{
                _bigPicture = NO;
            }
            
            _pictureRect = CGRectMake(margin,contentY + contentH + margin, picW, picH);
            _cellHeight += picH +margin;
        }else if (self.type == WLTopicTypeVoice){
            CGFloat voiceImageX = margin;
            CGFloat voiceImageY = contentY + contentH + margin;
            CGFloat voiceImageW = maxSize.width;
            CGFloat voiceImageH = voiceImageW * (self.height / self.width);
            _voiceRect = CGRectMake(voiceImageX, voiceImageY, voiceImageW, voiceImageH);
            _cellHeight += voiceImageH +margin;
        }else if(self.type == WLTopicTypeAudio){
            CGFloat videoImageX = margin;
            CGFloat videoImageY = contentY + contentH + margin;
            CGFloat videoImageW = maxSize.width;
            CGFloat videoImageH = videoImageW * (self.height / self.width);
            _videoRect = CGRectMake(videoImageX, videoImageY, videoImageW, videoImageH);
            _cellHeight += videoImageH + margin;
        }
        
        if (self.top_cmt.count != 0) {
            _topCmt = YES;
            WLTopComment *comment = self.top_cmt[0];
            WLUser *user = comment.user;
            NSString *topCmtInfo = [NSString stringWithFormat:@"%@:%@",user.username,comment.content];
            CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * margin, MAXFLOAT);
            CGFloat contentH  = [topCmtInfo boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:WLCellFont} context:nil].size.height;
            _topcmtRect = CGRectMake(margin, _cellHeight, maxSize.width, contentH);
            _cellHeight +=contentH + cellTopcmtH +margin ;
        }else{
            _topCmt = NO;
        }
        _cellHeight += bottomH + margin;
    }
    
    return _cellHeight;
}
@end
