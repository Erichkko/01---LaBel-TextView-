//
//  WLLoginAndRegisterController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/24.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLLoginAndRegisterController.h"

@interface WLLoginAndRegisterController ()

@end

@implementation WLLoginAndRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)exitClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
