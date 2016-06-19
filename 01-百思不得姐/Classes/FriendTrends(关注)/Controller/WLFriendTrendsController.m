//
//  WLFriendTrendsController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLFriendTrendsController.h"
#import "WLRecommedController.h"

@interface WLFriendTrendsController ()

@end

@implementation WLFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
   self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithViewContoller:self normalImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" action:@selector(leftBarButtonItem)];
    self.view.backgroundColor = WLGlobalColor;
}

-(void)leftBarButtonItem
{
    WLLogFunc;
    WLRecommedController *recommedVc = [[WLRecommedController alloc] init];
    
    [self.navigationController pushViewController:recommedVc animated:YES];
    
    
}

@end
