//
//  WLRecommedController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLRecommedController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface WLRecommedController ()

@end

@implementation WLRecommedController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐关注";
    self.view.backgroundColor = WLGlobalColor;
    [self loadWebData];
}

- (void)loadWebData
{
    
    
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WLLog(@"responseObject  = %@",responseObject);
        [SVProgressHUD showSuccessWithStatus:@"加载成功！"];
        [SVProgressHUD dismissWithDelay:1.0];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WLLog(@"error === %@",error);
        [SVProgressHUD showErrorWithStatus:@"加载失败！"];
        [SVProgressHUD dismissWithDelay:1.0];
        [SVProgressHUD dismiss];
    }];
}


@end
