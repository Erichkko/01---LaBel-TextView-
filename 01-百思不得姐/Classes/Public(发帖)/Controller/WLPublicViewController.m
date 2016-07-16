//
//  WLPublicViewController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/1.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLPublicViewController.h"
#import "WLPublish.h"
#import "WLPublicTopicViewController.h"

#import "WLNavigationBar.h"
#import "WLLoginTool.h"

#import <POP.h>


#define delTime 0.1
@interface WLPublicViewController ()
/** sloganView */
@property(nonatomic,weak)  UIImageView *sloganView;

@end

@implementation WLPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
}

- (void) setupView
{
    
    self.view.userInteractionEnabled = NO;
    NSArray *btnImages = @[@"publish-audio",@"publish-offline",@"publish-picture",@"publish-review",@"publish-text",@"publish-video"];
    NSArray *titles = @[@"发音频",@"离线下载",@"发图片",@"审帖",@"发段子",@"发音频"];
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.centerx = self.view.centerx;
    sloganView.centery = - WLWindow.height;
    [self.view addSubview:sloganView];
    self.sloganView =  sloganView;
    
    NSInteger rowCount = 3;
    
    CGFloat btnW = 72;
    CGFloat btnH = 102;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat marginTop = self.view.height * 0.5;
    
    CGFloat margin = (WLWindow.width - rowCount * btnW) / (1 + rowCount) ;
    for (int i = 0; i < btnImages.count; i++) {
        
        btnX = (i % rowCount) * (btnW +margin) + margin;
        btnY = (i / rowCount) * (btnH +margin)+ margin + marginTop;
        WLPublish *button = [WLPublish buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(btnX, -WLWindow.height, btnW, btnH);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:btnImages[i]] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
   
            
            POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
            anim.springBounciness = 5;
            anim.springSpeed = 5;
            anim.beginTime = CACurrentMediaTime() + delTime * i;
            anim.fromValue = @(btnY-1000 - WLWindow.height);
            anim.toValue = @(btnY);
            [button.layer pop_addAnimation:anim forKey:nil];
     
    }
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.beginTime = CACurrentMediaTime() + btnImages.count * delTime;
    anim.fromValue = @(-self.view.height * 0.3);
    anim.toValue = @(self.view.height * 0.3);
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView.layer pop_addAnimation:anim forKey:nil];
    
    
    
}


-(void)cancelCompleteBlock:(void(^)())completeBlock
{
    
    for (int i = 3; i < 9; i++) {
        WLPublish *publishBtn = self.view.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.beginTime = CACurrentMediaTime() + (8 - i)* delTime;
        anim.toValue = @(publishBtn.y + self.view.height);
        //设置动画执行 加速减速还是匀速
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [publishBtn.layer pop_addAnimation:anim forKey:nil];
    }
    
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.beginTime = CACurrentMediaTime() + 6 * delTime;
    anim.toValue = @(self.sloganView.y + self.view.height);
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        [self dismissViewControllerAnimated:NO completion:nil];
        if (completeBlock != nil) {
            completeBlock();
        }
    }];
    [self.sloganView.layer pop_addAnimation:anim forKey:nil];
}
- (void)clickBtn:(UIButton *)btn
{
    [self cancelCompleteBlock:^{
        if (btn.tag == 4) {
            if([WLLoginTool getUid] == nil){
                [WLLoginTool checkIsLogin];
                return ;
            }
            
            WLPublicTopicViewController *publicTopicVc = [[WLPublicTopicViewController alloc] init];
 
            WLNavigationBar *navVc = [[WLNavigationBar alloc] initWithRootViewController:publicTopicVc];
            UITabBarController *tabbarVc = (UITabBarController *)WLWindow.rootViewController;
            [tabbarVc presentViewController:navVc animated:YES completion:nil];
        }else if(btn.tag == 0){
            WLLog(@"发音频");
        }
//            [self cancel];
    }];
    
}
- (IBAction)cancelClick:(id)sender {
    [self cancel];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancel];
}

- (void)cancel
{
    [self cancelCompleteBlock:nil];
}



@end
