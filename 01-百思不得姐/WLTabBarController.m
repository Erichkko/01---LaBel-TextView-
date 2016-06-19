//
//  WLTabBarController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTabBarController.h"

@interface WLTabBarController ()

@end

@implementation WLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    
    NSMutableDictionary *selectAttrDict = [NSMutableDictionary dictionary];
    selectAttrDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    selectAttrDict[NSFontAttributeName] = attrDict[NSFontAttributeName];
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:attrDict forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrDict forState:UIControlStateSelected];
    
    UIViewController *vc01 = [[UIViewController alloc] init];
    vc01.view.backgroundColor = [UIColor redColor];
    vc01.tabBarItem.title = @"精华";
 
    [vc01.tabBarItem setTitleTextAttributes:attrDict forState:UIControlStateNormal];
    vc01.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    UIImage *selectImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc01.tabBarItem.selectedImage = selectImage;
    [self addChildViewController:vc01];
    
    UIViewController *vc02 = [[UIViewController alloc] init];
    vc02.view.backgroundColor = [UIColor yellowColor];
    vc02.tabBarItem.title = @"新帖";
    vc02.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc02.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    [self addChildViewController:vc02];
    
    
    UIViewController *vc03 = [[UIViewController alloc] init];
    vc03.view.backgroundColor = [UIColor whiteColor];
    vc03.tabBarItem.title = @"关注";
    vc03.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc03.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    [self addChildViewController:vc03];
    
    
    UIViewController *vc04 = [[UIViewController alloc] init];
    vc04.view.backgroundColor = [UIColor blueColor];
    vc04.tabBarItem.title = @"我";
    vc04.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc04.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    [self addChildViewController:vc04];

}



@end
