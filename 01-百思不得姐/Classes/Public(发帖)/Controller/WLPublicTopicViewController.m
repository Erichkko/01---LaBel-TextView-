//
//  WLPublicTopicViewController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/10.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLPublicTopicViewController.h"
#import "WLPlaceholderTextView.h"
#import "WLAddTagToolBar.h"
#import "WLAddTagViewController.h"
@interface WLPublicTopicViewController ()<UITextViewDelegate,WLAddTagToolBarDelegate>
/** textView */
@property(nonatomic,weak)  WLPlaceholderTextView *textView ;
/** toolBar */
@property(nonatomic,weak) WLAddTagToolBar *toolBar;

@end

@implementation WLPublicTopicViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self setupTextView];
    [self setupToolBar];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     [self.textView becomeFirstResponder];
}

- (void)setupTextView
{
    WLPlaceholderTextView *textView = [[WLPlaceholderTextView alloc] init];
    textView.delegate =self;
    textView.frame = self.view.bounds;
    textView.placeholderColor = [UIColor redColor];
    textView.placeholder = @"66影视每天免费提供最新免费高清电影资源,有最新最热门的电影、电视剧、动漫、综艺,并提供多种在线观看方式,包括西瓜影音、快播、土豆、优酷等,给你打造最方便的免费.";
    [self.view addSubview:textView];
    self.textView = textView;
    [WLNoteCenter addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
   
}


- (void)keyboardWillChange:(NSNotification *)note
{
    CGRect keyboardF=  [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
//        self.toolBar.y += endRect.origin.y - beginRect.origin.y ;
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, keyboardF.origin.y - WLScreenH );
    }];
}

- (void)setupNavView
{

    self.title = @"发段子";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}


- (void)setupToolBar
{
    WLAddTagToolBar *toolBar = [WLAddTagToolBar toolBarView];
    toolBar.width = self.view.width;
    toolBar.y = self.view.height - toolBar.height;
    toolBar.deleagte =self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    
    
//    self.textView.inputAccessoryView = toolBar;
}
- (void)done
{
    
}
- (void)cancel
{
     [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - WLAddTagToolBarDelegate

- (void)addTagClickBtnPlus:(WLAddTagToolBar *)toolBar
{
    WLLogFunc;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}




- (void)dealloc
{
    [WLNoteCenter removeObserver:self];
}
@end
