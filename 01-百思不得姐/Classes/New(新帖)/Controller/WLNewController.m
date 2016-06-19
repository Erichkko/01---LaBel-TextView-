//
//  WLNewController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLNewController.h"

@interface WLNewController ()

@end

@implementation WLNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

   self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithViewContoller:self normalImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" action:@selector(leftBarButtonItem)];
    self.view.backgroundColor = WLGlobalColor;
}

-(void)leftBarButtonItem
{
    WLLogFunc;
}

@end
