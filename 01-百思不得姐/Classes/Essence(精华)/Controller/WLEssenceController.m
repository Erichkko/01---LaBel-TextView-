//
//  WLEssenceController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/19.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLEssenceController.h"
#import "WLRecommendViewController.h"
#import "WLTopicViewController.h"


#define TypeCount 5
@interface WLEssenceController ()<UIScrollViewDelegate>
/** indicatorView */
@property(nonatomic,strong)UIView *indicatorView;
/** titleView */
@property(nonatomic,strong)UIView *titleView;
/** currentSelectedBtn */
@property(nonatomic,strong)UIButton *currentSelectedBtn;
/** contentScrollView */
@property(nonatomic,strong)UIScrollView *contentScrollView;
@end

@implementation WLEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVc];
    [self setupGlobal];
    [self setupTitleList];
    [self setupContentView];
}


- (void)setupChildVc
{
    WLTopicViewController *allVc = [[WLTopicViewController alloc] init];
    allVc.title = @"全部";
    allVc.type = WLTopicTypeAll;
    [self addChildViewController:allVc];
    
    WLTopicViewController *videoVc = [[WLTopicViewController alloc] init];
    videoVc.title = @"视频";
    videoVc.type = WLTopicTypeAudio;
    [self addChildViewController:videoVc];
    
    WLTopicViewController *voiceVc = [[WLTopicViewController alloc] init];
    voiceVc.title = @"声音";
    voiceVc.type = WLTopicTypeVoice;
    [self addChildViewController:voiceVc];
    
    WLTopicViewController *pictureVc = [[WLTopicViewController alloc] init];
    pictureVc.title = @"图片";
    pictureVc.type = WLTopicTypePicture;
    [self addChildViewController:pictureVc];
    
    WLTopicViewController *textVc = [[WLTopicViewController alloc] init];
    textVc.title = @"段子";
    textVc.type = WLTopicTypeWord;
    [self addChildViewController:textVc];
}
/**
 *  初始化标题和主背景颜色以及nav的点击事件
 */
- (void)setupGlobal
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithViewContoller:self normalImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" action:@selector(leftBarButtonItem)];
    self.view.backgroundColor = WLGlobalColor;
}

/**
 *  初始化分类标题
 */
-(void)setupTitleList
{

    UIView *titleView = [[UIView alloc] init];

    titleView.frame = CGRectMake(0, titleViewH, self.view.width, titleViewY);
    titleView.backgroundColor = WLRGBAColor(255, 255, 255, 0.6);
    [self.view addSubview:titleView];

    //指示器view
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height  = 2;
    indicatorView.y = titleView.height - indicatorView.height;

    self.titleView = titleView;
    indicatorView.tag = -1;
    self.indicatorView = indicatorView;
    
//    NSArray *titleArray = @[@"全部全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat btnW = self.view.width / TypeCount;
    CGFloat btnH = 30;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    for (int i = 0; i < TypeCount; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btnX = i * btnW;
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        if (i == 0) {
            [button.titleLabel sizeToFit];
            button.enabled = NO;
            self.currentSelectedBtn = button;
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerx = button.centerx;
        }
    }
    [titleView addSubview:indicatorView];
}

- (void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.contentSize = CGSizeMake(self.view.width *TypeCount, 0);
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    [self.view insertSubview:contentView atIndex:0];
    self.contentScrollView = contentView;
    [self scrollViewDidEndScrollingAnimation:contentView];
}

/**
 *  titleList 点击事件
 *
 *  @param btn btn
 */
- (void)btnClick:(UIButton *)btn
{
    self.currentSelectedBtn.enabled = YES;
    btn.enabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = btn.titleLabel.width;
        self.indicatorView.centerx = btn.centerx;
    }];
    
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = btn.tag * (self.contentScrollView.width);
    [self.contentScrollView setContentOffset:offset animated:YES];
    
    self.currentSelectedBtn = btn;
}
-(void)leftBarButtonItem
{
    WLLogFunc;
    WLRecommendViewController *tagVc = [[WLRecommendViewController alloc] init];
    
    [self.navigationController pushViewController:tagVc animated:YES];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.width = scrollView.width;
    vc.view.height = scrollView.height;
    [self.contentScrollView addSubview:vc.view];
}

/**
 *  手动拖拽 减速完毕
 *
 *  @param scrollView 目标scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self btnClick:self.titleView.subviews[index]];
}
@end
