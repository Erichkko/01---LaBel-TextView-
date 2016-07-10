//
//  WLMeFooterView.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/9.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLMeFooterView.h"
#import "WLSquare.h"
#import "WLWebController.h"

#import "WLSquareBtn.h"

@implementation WLMeFooterView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.height = 150;
//        self.backgroundColor = [UIColor redColor];
//        [self setTableViewFooter];
        
    }
    return self;
}

//- (void)drawRect:(CGRect)rect
//{
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}

- (void)setSquares:(NSArray *)squares
{
    _squares =squares;

    [self setupSubChilds];
    
    
}

- (void)setupSubChilds
{
   
    NSInteger rowConnt = 4;
    CGFloat btnW = WLScreenW / 4;
    CGFloat btnH = btnW + 20;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    for (int i = 0; i < self.squares.count; i++) {
        WLSquare *square = self.squares[i];
        NSInteger row = i % rowConnt;
        NSInteger col = i / rowConnt;
        btnX = row * btnW;
        btnY = col * btnH;
        WLSquareBtn *btn = [WLSquareBtn buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setSquare:square];
        [btn setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        [self addSubview:btn];
        
    }
    NSInteger colCount = (self.squares.count + rowConnt - 1)/rowConnt;

    self.height = colCount * btnH;
    [self setNeedsDisplay];
}

- (void)clickBtn:(WLSquareBtn *)btn
{
    WLSquare *square =btn.square;
    
    WLLog(@"url == %@",square.url);
        if (![square.url hasPrefix:@"http://"]) {
        return;
    }
    WLWebController *webVc = [[WLWebController alloc] init];
    webVc.square = square;
    UITabBarController *tabbarVc = (UITabBarController *)WLWindow.rootViewController;
    UINavigationController *navVc = (UINavigationController *)tabbarVc.selectedViewController;
//    webVc.hidesBottomBarWhenPushed = YES;
    [navVc pushViewController:webVc animated:YES];

}

@end
