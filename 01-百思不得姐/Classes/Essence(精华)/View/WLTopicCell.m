//
//  WLTopicCell.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/26.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTopicCell.h"
#import "WLTopic.h"
#import <UIImageView+WebCache.h>

@interface WLTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageview;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caibtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sinaVImageView;
@end
@implementation WLTopicCell


+ (instancetype)topicCell
{
     WLTopicCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:kNilOptions] lastObject];
    return cell;
}
- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
    self.backgroundView = bgView;
}



- (void)setTopic:(WLTopic *)topic
{
    _topic = topic;
    
    [self.profileImageview sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.timeLabel.text = topic.create_time;
    
    topic.sina_v = arc4random_uniform(100)%2;
    if (topic.sina_v == 1) {
        self.sinaVImageView.hidden = NO;
    }else{
        self.sinaVImageView.hidden = YES;
    }
    
    //设置cell的底部数据
    [self formatStringWithNumber:topic.ding andBtn:self.dingBtn];
    [self formatStringWithNumber:topic.cai andBtn:self.caibtn];
    [self formatStringWithNumber:topic.repost andBtn:self.shareBtn];
    [self formatStringWithNumber:topic.comment andBtn:self.commentBtn];

    
}

- (void) formatStringWithDateStr:(NSString *)dateStr andLabel:(UILabel *)dateLabel
{
    
    //方法1 通过NSDate求秒数差值 不过有点麻烦
//    //2016-06-26 15:08:07
//    NSDate *now = [NSDate date];
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *formatDate = [fmt dateFromString:dateStr];
//    NSTimeInterval delTime = [now timeIntervalSinceDate:formatDate];
  
    
    //方法2 通过NSCalendar求时间差
//    NSDate *now = [NSDate date];
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *formatDate = [fmt dateFromString:dateStr];
//    WLLog(@"cmps == %@",[now delDateFrom:formatDate ]);
    
    //3.测试时间是否正确
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *formatDate = [fmt dateFromString:dateStr];
    WLLog(@"dateStr == %@",dateStr);
    WLLog(@"nowDate == %@",[NSDate date]);
    
    if (formatDate.isYear) {
        if (formatDate.isToday) {
            NSDateComponents *cmps = [[NSDate date] delDateFrom:formatDate];
            if (cmps.hour > 0) {
                fmt.dateFormat = @"HH小时之前";
                dateLabel.text = [NSString stringWithFormat:@"%zd小时之前",cmps.hour];
            }else if(cmps.minute > 0){
                fmt.dateFormat = @"mm分钟之前";
                dateLabel.text = [NSString stringWithFormat:@"%zd分钟之前",cmps.minute];
            }else{
                fmt.dateFormat = @"刚刚";
                dateLabel.text = [fmt stringFromDate:formatDate];
            }
            
            
        }else if (formatDate.isYesterday){
            fmt.dateFormat = @"昨天 HH:mm:ss";
            dateLabel.text = [fmt stringFromDate:formatDate];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            dateLabel.text = [fmt stringFromDate:formatDate];
        }
    } else{
        dateLabel.text = dateStr;
    }
    
}
- (void) formatStringWithNumber:(NSInteger)number andBtn:(UIButton *)btn
{
    NSString *string = nil;
    if(number == 0){
        if (btn == self.dingBtn) {
            string = @"顶";
        }else if (btn == self.caibtn) {
            string = @"踩";
        }else if (btn == self.shareBtn) {
            string = @"分享";
        }else if (btn == self.commentBtn) {
            string = @"评论";
        }
        
    }else if(number >= 10000){
        string = [NSString stringWithFormat:@"%.1f万",number / 10000.0];
    }else if(number >= 10000000){
        string = [NSString stringWithFormat:@"%.1f亿",number / 10000000.0];
    }else{
         string = [NSString stringWithFormat:@"%zd",number];
    }
    [btn setTitle:string forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height  -= margin;
    frame.origin.y += margin;
    [super setFrame:frame];
}
@end
