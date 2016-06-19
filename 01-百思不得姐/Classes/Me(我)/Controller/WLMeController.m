//
//  WLMeController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLMeController.h"

@interface WLMeController ()

@end

@implementation WLMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";

    UIBarButtonItem *setBarBtn = [UIBarButtonItem itemWithViewContoller:self normalImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" action:@selector(setBarButtonItem)];
    UIBarButtonItem *moonBarBtn = [UIBarButtonItem itemWithViewContoller:self normalImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" action:@selector(moonBarButtonItem)];
    
    NSArray *rightArry = @[setBarBtn,moonBarBtn];
    
    self.navigationItem.rightBarButtonItems = rightArry;
    self.view.backgroundColor = WLGlobalColor;
    
}

-(void)setBarButtonItem
{
    WLLogFunc;
}

-(void)moonBarButtonItem
{
    WLLogFunc;
}
@end
