//
//  WLPIcture.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/29.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLPIcture.h"
#import "WLTopic.h"
#import "WLBigPictureViewController.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
@interface WLPIcture()
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@property (weak, nonatomic) IBOutlet UIButton *bigPictureBtn;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@end

@implementation WLPIcture

- (void)awakeFromNib
{
    self.autoresizingMask =UIViewAutoresizingNone;
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.pictureImageView.userInteractionEnabled  = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPicture)];
    [self.pictureImageView addGestureRecognizer:tap];
}
+ (instancetype)picture
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
//    if ([self.delegate respondsToSelector:@selector(picture:showBigPictureWithTopic:)]) {
//        [self.delegate picture:self showBigPictureWithTopic:self.topic];
//    }
    WLLogFunc;
}

- (void)setTopic:(WLTopic *)topic
{
    _topic = topic;
    [self.progressView setProgress:topic.pictureProgess];
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage] placeholderImage:nil options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
       topic.pictureProgess = 1.0 * receivedSize/expectedSize;
        [self.progressView setProgress:topic.pictureProgess];
        
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",topic.pictureProgess *100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        UIGraphicsBeginImageContextWithOptions(topic.pictureRect.size, YES, 0.0);
        
        CGFloat width = topic.pictureRect.size.width;
        
        CGFloat height = width * topic.height / topic.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        self.pictureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }];

    NSString *imgExtension = topic.smallImage.pathExtension;
    
    self.gifImageView.hidden = ![imgExtension.lowercaseString isEqualToString:@"gif"];
    
    self.bigPictureBtn.hidden = !topic.isBigPicture;
//    UIViewContentModeScaleAspectFit 保住看到图片的全部
//    UIViewContentModeScaleToFill   压缩后 裁剪
    if (topic.isBigPicture) {
        self.bigPictureBtn.hidden = NO;
        self.pictureImageView.clipsToBounds = YES;
//        self.pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    } else {
         self.bigPictureBtn.hidden = YES;
//        self.pictureImageView.contentMode = UIViewContentModeScaleToFill;

    }
    
}
@end
