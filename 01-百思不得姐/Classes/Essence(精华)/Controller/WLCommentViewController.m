//
//  WLCommentViewController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/3.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLCommentViewController.h"
#import "WLTopicCell.h"
#import "WLTopic.h"
#import "WLComment.h"
#import "WLTopComment.h"
#import "WLAllComment.h"
#import "WLCommentView.h"


#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>

@interface WLCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cmtTextField;
/** comments */
@property(nonatomic,strong)WLAllComment *comment;
/** save_top_cmt */
@property(nonatomic,assign)BOOL isTopCmt;
/** save_top_cmt */
@property(nonatomic,strong)NSArray *save_top_cmt;
/**page*/
@property(nonatomic,assign)NSInteger page ;

@end

@implementation WLCommentViewController

    static NSString * const commentId = @"commentId";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setupHeader];
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)] ;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
    self.tableView.mj_footer.hidden = YES;
}


- (void)loadMoreComment
{
    NSInteger nextPage = self.page +1;
   
    
    WLComment *lastCmt = [self.comment.data lastObject];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"datalist";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.topicId;
    params[@"hot"] =@(1);
    params[@"page"] = @(nextPage);
    params[@"lastcid"] = lastCmt.commentId;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:WLURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
       WLAllComment *newData = [WLAllComment mj_objectWithKeyValues:responseObject];
        
        [self.comment.data addObjectsFromArray:newData.data];
  
        
        self.page = nextPage ;
        
        NSInteger totalCount = [responseObject[@"total"] integerValue];
        
        if (self.comment.data.count + self.comment.hot.count >= totalCount) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
              [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WLLog(@"error66");
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (void)loadNewComment
{
    WLLogFunc;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"datalist";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.topicId;
    params[@"hot"] =@(1);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:WLURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        WLLog(@"==== %@",responseObject);
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        self.comment = [WLAllComment mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        self.page = 1;
        NSInteger totalCount = [responseObject[@"total"] integerValue];
        
        if (self.comment.data.count + self.comment.hot.count >= totalCount) {
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WLLog(@"error");
        [self.tableView.mj_header endRefreshing];

    }];
    
}

- (void)setupHeader
{
    //包裹一层view 可以更好的处理头部尾部View
    //同时注意setFrame 的调用次数 会影响 cell的y值
    
    UIView *header = [[UIView alloc] init];
    WLTopicCell *topicCell = [WLTopicCell topicCell];
    
    if (self.topic.top_cmt.count) {
        self.save_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@(0) forKey:@"cellHeight"];
    }
    
    topicCell.topic = self.topic;
    topicCell.size = CGSizeMake(WLWindow.width, self.topic.cellHeight);

    header.height = self.topic.cellHeight + margin;
    [header addSubview:topicCell];
    self.tableView.tableHeaderView = header;
   


   
}
- (void)setup
{
    self.title = @"评论";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.contentInset = UIEdgeInsetsMake(titleViewH, 0, margin, 0);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithViewContoller:self normalImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" action:@selector(more)];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.view.backgroundColor = WLGlobalColor;
    
    self.tableView.estimatedRowHeight  = 64;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WLCommentView class]) bundle:nil] forCellReuseIdentifier:commentId];

}

- (void)keyboardChange:(NSNotification *)ntc
{
//    NSDictionary *useInfo = ntc.userInfo;
    CGFloat animDuration = [ntc.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endkeyBoardF =  [ntc.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomConstraint.constant = WLWindow.height - endkeyBoardF.origin.y;

    [UIView animateWithDuration:animDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)dealloc
{
    if (self.save_top_cmt.count) {
        self.topic.top_cmt = self.save_top_cmt ;
        [self.topic setValue:@(0) forKey:@"cellHeight"];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    menu.menuItems = nil;
}
- (void)more
{
    WLLogFunc;
}

- (NSArray *)commentsInSection:(NSInteger)section
{    NSInteger hotCount = self.comment.hot.count;
    if (section == 0) {
        return hotCount != 0?self.comment.hot:self.comment.data;
    }
    return self.comment.data;
}

- (WLComment *)commentIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [self commentsInSection:indexPath.section];
    WLComment *cmt = array[indexPath.row];
    return cmt;
}
#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.comment.hot.count;
    NSInteger dataCount = self.comment.data.count;
    
    
    if (hotCount > 0) {
        return 2;
    }
    if (dataCount >0) {
        return 1;
    }
    return 0;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.comment.hot.count;
    NSInteger dataCount = self.comment.data.count;
    tableView.mj_footer.hidden = (dataCount == 0);
    
    if (section == 0) {
        return hotCount != 0?hotCount:dataCount;
    }
    if (section  == 1) {
        return dataCount;
    }
    return 0;
}




- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //设置每组头部标题（自定义View）
    NSInteger hotCount = self.comment.hot.count;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = WLGlobalColor;
    UILabel *sectionHeader = [[UILabel alloc] init];
    sectionHeader.x = margin;
    sectionHeader.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    if (section == 0) {
        sectionHeader.text = hotCount != 0?@"热门评论":@"最新评论";
    }
    if (section  == 1) {
        sectionHeader.text =  @"最新评论";
    }
    [view addSubview:sectionHeader];
 
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    WLCommentView *cell = [tableView dequeueReusableCellWithIdentifier:commentId];
    cell.comment = [self commentIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    if (menu.menuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else{
        WLCommentView *cell = (WLCommentView *)[tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];

        UIMenuItem *dingItem = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replayItem = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(ding:)];
        UIMenuItem *commentItem = [[UIMenuItem alloc] initWithTitle:@"评论" action:@selector(ding:)];
        
        menu.menuItems = @[dingItem,replayItem,commentItem];
        
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height *0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
   
}


- (void)ding:(UIMenuItem *)item
{
    NSIndexPath *indexPath =[self.tableView indexPathForSelectedRow];
    
    WLComment *comment = [self commentIndexPath:indexPath];
    WLLog(@"comment == %@",comment.content);
}
- (void)replay:(UIMenuItem *)item
{
    NSIndexPath *indexPath =[self.tableView indexPathForSelectedRow];

    WLComment *comment = [self commentIndexPath:indexPath];
    WLLog(@"comment == %@",comment.content);
}
- (void)comment:(UIMenuItem *)item
{
    NSIndexPath *indexPath =[self.tableView indexPathForSelectedRow];

    WLComment *comment = [self commentIndexPath:indexPath];
    WLLog(@"comment == %@",comment.content);
}
@end
