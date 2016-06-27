//
//  WLTextViewController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/26.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTopicViewController.h"
#import "WLTopic.h"
#import "WLTopicCell.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import <MJExtension.h>

@interface WLTopicViewController ()

/** topics段子 */
@property(nonatomic,strong)NSMutableArray *topics;
/**page*/
@property(nonatomic,assign)NSInteger page;
/** maxtime */
@property(nonatomic,strong)NSString *maxtime;
/** params网络请求过滤 */
@property(nonatomic,strong)NSMutableDictionary *params;

@end

@implementation WLTopicViewController
static  NSString * const ID = @"topicCell";
- (NSMutableArray *)topics
{
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableview];
}

- (void)setupTableview
{
    
    //header
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //footer
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //tableview
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = titleViewH +titleViewY ;
    
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //other
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //    [self.tableView registerNib:[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WLTopicCell class]) owner:nil options:kNilOptions] lastObject] forCellReuseIdentifier:ID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WLTopicCell class]) bundle:nil] forCellReuseIdentifier:ID];
    [self.tableView setRowHeight:180.0];
}

- (void)loadNewData
{
    
    [self.tableView.mj_footer endRefreshing];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    [manager GET:WLURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params ) {
            return ;
        }
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.topics = [WLTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"] ];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params ) {
            return ;
        }
        [self.tableView.mj_header endRefreshing];
    }];
    
}
-(void)loadMoreData
{
    [self.tableView.mj_header endRefreshing];
    NSInteger pageIndex =  self.page + 1;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(pageIndex);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    [manager GET:WLURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params ) {
            return ;
        }
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *moreTopics = [WLTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"] ];
        [self.topics addObjectsFromArray:moreTopics];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        self.page++;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params ) {
            return ;
        }
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0)?YES:NO;
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLTopic *topic = self.topics[indexPath.row];
    WLTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.topic =topic;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0;
}
@end