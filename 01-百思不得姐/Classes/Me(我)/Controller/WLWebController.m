//
//  WLWebController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/9.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLWebController.h"
#import "WLSquare.h"
@interface WLWebController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForward;
@end

@implementation WLWebController
- (IBAction)refresh:(id)sender {
    [self.webView reload];
  
}
- (IBAction)back:(id)sender {
   
        [self.webView goBack];
    
    
}
- (IBAction)forward:(id)sender {
         [self.webView goForward];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBasic];
    [self loadWebView];
   

    
}

- (void)setupBasic
{
    self.title = self.square.name;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.webView.delegate = self;
}
- (void)loadWebView
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.square.url]]];
    
}
#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goForward.enabled = webView.canGoForward;
    self.goBackItem.enabled = webView.canGoBack;
}
@end
