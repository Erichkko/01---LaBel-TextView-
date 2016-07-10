//
//  WLMeController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLMeController.h"
#import "WLMeCell.h"
#import "WLSquare.h"
#import "WLMeFooterView.h"
#import <AFNetworking.h>
#import <MJExtension.h>
@interface WLMeController ()
/** squares */
@property(nonatomic,strong)NSArray *squares;
@end

@implementation WLMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
//    [self setTableViewFooter];
    [self loadData];
    
}

- (void)setupBasic
{
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *setBarBtn = [UIBarButtonItem itemWithViewContoller:self normalImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" action:@selector(setBarButtonItem)];
    UIBarButtonItem *moonBarBtn = [UIBarButtonItem itemWithViewContoller:self normalImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" action:@selector(moonBarButtonItem)];
    
    NSArray *rightArry = @[setBarBtn,moonBarBtn];
    
    self.navigationItem.rightBarButtonItems = rightArry;
    self.view.backgroundColor = WLGlobalColor;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    //改变每组之间的间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = margin;
    //设置footerView
    self.tableView.tableFooterView = [[WLMeFooterView alloc] init];
}

- (void)loadData
{
      AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    [manager GET:WLURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WLLog(@"responseObject == %@",responseObject);
        
        WLMeFooterView *footerView = (WLMeFooterView *)self.tableView.tableFooterView;
        [footerView setSquares: [WLSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]]];
        CGFloat btnW = WLScreenW / 4;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WLLog(@"error = %@",error);
        nil;
    }];
    
}
-(void)setBarButtonItem
{
    WLLogFunc;
}

-(void)moonBarButtonItem
{
    WLLogFunc;
}

#pragma mark - UITableViewDataSources
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 
    return 2;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const cellID = @"cellID";
    
    WLMeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[WLMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    }else{
        cell.textLabel.text = @"离线下载";
    }

    return cell;
}


@end
