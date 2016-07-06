//
//  WLBigPictureViewController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/30.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLBigPictureViewController.h"
#import "WLTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <DALabeledCircularProgressView.h>

@interface WLBigPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progessView;

/** bigPictureView */
@property(nonatomic,weak)UIImageView *bigPictureView;
@end

@implementation WLBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //如果通过XIB 创建的View 得到的尺寸 会不准
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *bigPictureView = [[UIImageView alloc] init];
    
    
    bigPictureView.userInteractionEnabled =  YES;
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pan)];
    
    [bigPictureView addGestureRecognizer:pan];
    [self.scrollview addSubview:bigPictureView];
    self.bigPictureView = bigPictureView;
    CGFloat screenW = WLWindow.frame.size.width;
    CGFloat screenH = WLWindow.frame.size.height;
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    if (pictureH > screenH) {
        self.bigPictureView.frame =CGRectMake(0,0 , pictureW, pictureH);
        self.scrollview.contentSize= CGSizeMake(0, pictureH);
    }else{
        self.bigPictureView.size = CGSizeMake(pictureW, pictureH);
        self.bigPictureView.center = WLWindow.center;
    }
    
    self.progessView.roundedCorners = 5;
     [self.progessView setProgress:self.topic.pictureProgess];
    self.progessView.progressLabel.textColor = [UIColor whiteColor];
    
    self.bigPictureView.contentMode = UIViewContentModeScaleAspectFit;
    [self.bigPictureView sd_setImageWithURL:[NSURL URLWithString:self.topic.largeImage] placeholderImage:nil options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progessView.hidden = NO;
        self.topic.pictureProgess = 1.0 * receivedSize/expectedSize;
        [self.progessView setProgress:self.topic.pictureProgess];
        
        self.progessView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",self.topic.pictureProgess *100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progessView.hidden = YES;
    }];

}

- (void)pan
{ [self dismissViewControllerAnimated:YES completion:^{
    
}];
    
}
- (IBAction)exitBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
  
   
}
- (IBAction)savePicture {
    if (self.bigPictureView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片还没下载完成..."];
        return;
    }
    
    UIImageWriteToSavedPhotosAlbum(self.bigPictureView.image ,self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }else {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
}

@end
