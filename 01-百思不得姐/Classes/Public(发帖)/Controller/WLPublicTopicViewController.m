//
//  WLPublicTopicViewController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/10.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLPublicTopicViewController.h"
#import "WLPlaceholderTextView.h"

@interface WLPublicTopicViewController ()

@end

@implementation WLPublicTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self setupTextView];
    
}

- (void)setupTextView
{
    WLPlaceholderTextView *textView = [[WLPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholderColor = [UIColor redColor];
    textView.placeholder = @"66影视每天免费提供最新免费高清电影资源,有最新最热门的电影、电视剧、动漫、综艺,并提供多种在线观看方式,包括西瓜影音、快播、土豆、优酷等,给你打造最方便的免费.";
    
    [self.view addSubview:textView];
}

- (void)setupNavView
{

    self.title = @"发段子";
    
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)done
{
    
}
- (void)cancel
{
     [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
