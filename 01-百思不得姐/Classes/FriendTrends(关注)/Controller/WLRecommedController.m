//
//  WLRecommedController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLRecommedController.h"
#import "WLCategory.h"
#import "WLRecommedUser.h"
#import "WLLeftCell.h"
#import "WLRightCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>

#define WLSelectedCategory self.leftItems[self.leftTableView.indexPathForSelectedRow.row]

@interface WLRecommedController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;



/** leftItems */
@property(nonatomic,strong)NSMutableArray *leftItems;

/** rightItems */
@property(nonatomic,strong)NSMutableArray *rightItems;

/** params */
@property(nonatomic,strong) NSMutableDictionary *params;

/** manager */
@property(nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation WLRecommedController

static NSString * const CategoryId  = @"category";
static NSString * const RecommendUseryId  = @"recommendUser";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self setUpMJReFresh];
}


- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)setUpMJReFresh{
    
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.rightTableView.mj_footer.hidden = YES;
}

- (void)loadMoreData
{
    WLLogFunc;
    
    WLCategory *category = WLSelectedCategory;
  

    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.ID);
    params[@"page"] = @(++category.currentPage);
    self.params =  params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        WLLog(@"responseObject====%@",responseObject);
        NSMutableArray *arrayM = [WLRecommedUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.users addObjectsFromArray:arrayM];
        category.total = [responseObject[@"total"] integerValue];
        
        
        if (self.params != params) {
            return ;
        }
       
        [self.rightTableView reloadData];
        [self checkTableViewFooterStatus];
        [self.rightTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) {
            return ;
        }
        WLLog(@"error====%@",error);
        
    }];
}


- (void)loadNewData
{
    WLLogFunc;
    
    WLCategory *category = WLSelectedCategory;
    category.currentPage = 1;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.ID);
    params[@"page"] = @(category.currentPage);
    self.params = params;
    [self.manager  GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
     
        WLLog(@"responseObject====%@",responseObject);
        NSMutableArray *arrayM = [WLRecommedUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.users removeAllObjects];
        [category.users addObjectsFromArray:arrayM];
        category.total = [responseObject[@"total"] integerValue];
        
        if (self.params != params) {
            return ;
        }
        
        [self.rightTableView reloadData];
        [self checkTableViewFooterStatus];
        [self.rightTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) {
            return ;
        }
        WLLog(@"error====%@",error);
        
    }];
}


- (void)setUpView
{
    self.title = @"推荐关注";
    self.view.backgroundColor = WLGlobalColor;
    
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WLLeftCell class]) bundle:nil] forCellReuseIdentifier:CategoryId];
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WLRightCell class]) bundle:nil] forCellReuseIdentifier:RecommendUseryId];
    
    [self loadWebData];
    [WLCategory mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID":@"id"
                 };
    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.leftTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
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
        
        
        NSArray *array = responseObject[@"list"];
        self.leftItems = [WLCategory mj_objectArrayWithKeyValuesArray:array];
        [self.leftTableView reloadData];
        
        //初始化操作
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.leftTableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionTop];
//        [self tableView:self.leftTableView didSelectRowAtIndexPath:path];
        [self.rightTableView.mj_header beginRefreshing];
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


- (void) checkTableViewFooterStatus
{
    WLCategory *category = WLSelectedCategory;

    if (category.total == category.users.count) {
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.rightTableView.mj_footer endRefreshing] ;
    }
}
#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.rightTableView.mj_header endRefreshing];
    [self.rightTableView.mj_footer endRefreshing];
    if ([tableView isEqual:self.leftTableView]) {
         return self.leftItems.count;
    }else{
        WLCategory *category = WLSelectedCategory;
        self.rightTableView.mj_footer.hidden = (category.users.count == 0);
        [self checkTableViewFooterStatus];
        return category.users.count;
    }
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.leftTableView]) {
        WLLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryId];
        WLCategory *category = self.leftItems[indexPath.row];
        cell.category = category;
        return cell;
    }else{
        WLRightCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendUseryId];
        WLCategory *category = WLSelectedCategory;
        WLRecommedUser *recommedUser = category.users[indexPath.row];
        cell.user = recommedUser;
        return cell;
    }
  
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        WLCategory *category = self.leftItems[indexPath.row];
        if (category.users.count) {
            [self.rightTableView reloadData];
        }else{
            [self.rightTableView reloadData];
            [self.rightTableView.mj_header beginRefreshing];
        }
    } else {
        nil;
    }
}


#pragma mark - 控制器销毁

- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations ];
}
@end
