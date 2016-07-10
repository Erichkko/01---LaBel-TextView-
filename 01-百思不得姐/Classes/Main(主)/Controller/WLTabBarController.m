//
//  WLTabBarController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTabBarController.h"
#import "WLEssenceController.h"
#import "WLNewController.h"
#import "WLFriendTrendsController.h"
#import "WLMeController.h"
#import "WLNavigationBar.h"

#import "WLTabBar.h"

@interface WLTabBarController ()

@end

@implementation WLTabBarController


+ (void)initialize
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    
    NSMutableDictionary *selectAttrDict = [NSMutableDictionary dictionary];
    selectAttrDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    selectAttrDict[NSFontAttributeName] = attrDict[NSFontAttributeName];
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:attrDict forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrDict forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WLEssenceController *essenceVc = [[WLEssenceController alloc] init];
    [self setupViewController:essenceVc title:@"精华" normalImage:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    WLNewController *newVc = [[WLNewController alloc] init];
    [self setupViewController:newVc title:@"新帖" normalImage:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    
    WLFriendTrendsController *friendTrendsVc = [[WLFriendTrendsController alloc]  init];
    [self setupViewController:friendTrendsVc title:@"关注" normalImage:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    WLMeController *meVc = [[WLMeController alloc] initWithStyle:UITableViewStyleGrouped];
    [self setupViewController:meVc title:@"我" normalImage:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    [self setValue: [[WLTabBar alloc] init] forKey:@"tabBar"];
 

}
- (void)setupViewController:(UIViewController *)vc title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage
{
    //设置标题和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:normalImage];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    //添加 子控制器
    WLNavigationBar *navVc = [[WLNavigationBar alloc] initWithRootViewController:vc];
  
    [self addChildViewController:navVc];
}


@end
