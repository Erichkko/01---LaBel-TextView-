//
//  WLTopicCell.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/26.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTopicCell.h"
#import "WLTopic.h"
#import "WLPIcture.h"
#import "WLVoice.h"
#import "WLVideo.h"
#import "WLTopCommentView.h"
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
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

/** picture */
@property(nonatomic,weak)WLPIcture *picture;
/** voice */
@property(nonatomic,weak)WLVoice *voice;
/** video */
@property(nonatomic,weak)WLVideo *video;
/** video */
@property(nonatomic,weak)WLTopCommentView *topcmtView;
@end
@implementation WLTopicCell
- (WLPIcture *)picture
{
    if (_picture == nil) {
        WLPIcture *picture = [WLPIcture picture];
        [self.contentView addSubview:picture];
        _picture = picture;
    }
    return _picture;
}

- (WLVoice *)voice
{
    if (_voice == nil) {
        WLVoice *voice = [WLVoice voice];
        [self.contentView addSubview:voice];
        _voice = voice;
    }
    return _voice;
}


- (WLVideo *)video
{
    if (_video == nil) {
        WLVideo *video = [WLVideo videoView];
        [self.contentView addSubview:video];
        _video = video;
    }
    return _video;
}

- (WLTopCommentView *)topcmtView
{
    if (_topcmtView == nil) {
        WLTopCommentView *topcmtView= [WLTopCommentView commentView];
        [self.contentView addSubview:topcmtView];
        _topcmtView = topcmtView;
    }
    return _topcmtView;
}

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

    self.contentLabel.text = topic.text;
    
    //如果是图片
    if (self.topic.type == WLTopicTypePicture) {
        self.picture.hidden = NO;
        self.video.hidden = YES;
        self.voice.hidden = YES;
        self.picture.frame =topic.pictureRect;
        self.picture.topic = topic;
    }else if (self.topic.type == WLTopicTypeVoice){
        self.picture.hidden = YES;
        self.video.hidden = YES;
        self.voice.hidden = NO;
        self.voice.frame =topic.voiceRect;
        self.voice.topic = topic;
    }else if (self.topic.type == WLTopicTypeAudio){
        self.picture.hidden = YES;
        self.video.hidden = NO;
        self.voice.hidden = YES;
        self.video.topic = topic;
        self.video.frame = topic.videoRect;
    }else{
        self.picture.hidden = YES;
        self.video.hidden = YES;
        self.voice.hidden = YES;
        
    }
    
    if (self.topic.top_cmt.count != 0) {
        self.topcmtView.hidden = NO;
        self.topcmtView.topComment = topic.top_cmt[0];
        self.topcmtView.frame = topic.topcmtRect;
    }else{
        self.topcmtView.hidden = YES;
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
//    frame.size.height  -= margin;
    frame.size.height = self.topic.cellHeight - margin;
    frame.origin.y += margin;
    [super setFrame:frame];
}
- (IBAction)more:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WLLog(@"ok");
    }]];
  
  
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WLLog(@"123");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        WLLog(@"123");
    }]];
    [WLWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
    
    
}
@end
