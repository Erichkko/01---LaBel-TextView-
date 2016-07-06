//
//  WLAudio.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/3.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLVideo.h"
#import "WLTopic.h"
#import "WLBigPictureViewController.h"
#import <UIImageView+WebCache.h>

@interface WLVideo ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoTime;

@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UIButton *platBtn;

@end
@implementation WLVideo

+ (instancetype)videoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:kNilOptions] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
       self.videoImage.userInteractionEnabled  = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPicture)];
    [self.videoImage addGestureRecognizer:tap];
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
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playfcount];
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTime.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    [self.videoImage sd_setImageWithURL:[NSURL URLWithString:topic.largeImage]];
}
- (IBAction)playClick:(UIButton *)sender {
    WLLogFunc;
}

@end
