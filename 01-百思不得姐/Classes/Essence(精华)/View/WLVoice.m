
//
//  WLVoice.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/2.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLVoice.h"
#import "WLTopic.h"
#import "WLBigPictureViewController.h"
#import <UIImageView+WebCache.h>

@interface WLVoice()
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (weak, nonatomic) IBOutlet UILabel *voiceDuration;

@end
@implementation WLVoice

- (void)awakeFromNib
{
    self.autoresizingMask =UIViewAutoresizingNone;
       self.voiceImageView.userInteractionEnabled  = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPicture)];
    [self.voiceImageView addGestureRecognizer:tap];
}
+ (instancetype)voice
{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:kNilOptions] lastObject];
}


- (void) showBigPicture
{
    WLBigPictureViewController *bigPictureVc = [[WLBigPictureViewController alloc] init];
    
    bigPictureVc.topic = self.topic;
    
    [WLWindow.rootViewController presentViewController:bigPictureVc animated:YES completion:^{
        nil;
    }];
}


- (void)setTopic:(WLTopic *)topic
{
    _topic = topic;
    self.playCount.text = [NSString stringWithFormat:@"%zd次播发",topic.playfcount];
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voiceDuration.text  = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.smallImage]];
}
- (IBAction)playClick:(UIButton *)sender {
}


@end
