//
//  WLRecommendViewController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/22.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLRecommendViewController.h"
#import "WLRecommend.h"
#import "WLRecommendCell.h"


#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension.h>
@interface WLRecommendViewController ()
/** recommends */
@property(nonatomic,strong)NSArray *recommends;
@end

@implementation WLRecommendViewController
static NSString * const recommendID = @"recommend";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self requestWebData];
}

- (void)setupView
{
    self.title = @"关注标签";
    [self.tableView setRowHeight:90.0];
    self.tableView.backgroundColor = WLGlobalColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WLRecommendCell class]) bundle:nil] forCellReuseIdentifier:recommendID];
}

- (void) requestWebData
{
    [SVProgressHUD showWithStatus:@"加载数据"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WLLog(@"responseObject  = %@",responseObject);
         self.recommends = [WLRecommend mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
       [ SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [ SVProgressHUD dismiss];
    }];
    
}

#pragma mark - Table view data source
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recommends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WLRecommend *recommend = self.recommends[indexPath.row];
    WLRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendID];
    cell.recommend = recommend;
    return cell;
}


@end
