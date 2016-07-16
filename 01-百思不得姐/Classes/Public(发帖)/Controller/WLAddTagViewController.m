//
//  WLAddTagViewController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/10.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLAddTagViewController.h"
#import "WLTagButton.h"
#import "WLTagTextField.h"
#import <SVProgressHUD.h>

@interface WLAddTagViewController ()<UITextFieldDelegate>
/** containView */
@property(nonatomic,weak) UIView *containView ;
/** addBtn */
@property(nonatomic,weak)UIButton *addBtn;
/** textfield */
@property(nonatomic,weak)  WLTagTextField *textfield;

/** tagBtns */
@property(nonatomic,strong)NSMutableArray *tagBtns;

@end

@implementation WLAddTagViewController


#pragma mark - 懒加载
#pragma mark 加载tag数组
- (NSMutableArray *)tagBtns
{
    if (_tagBtns == nil) {
        _tagBtns = [NSMutableArray array];
    }
    return _tagBtns;
}

#pragma mark 加载btn按钮
- (UIButton *)addBtn
{
    if (_addBtn == nil) {
        UIButton *btn = [[UIButton alloc] init];
     
        btn.backgroundColor = WLTAGColor;
        btn.height = tagHeight;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.width = self.containView.width ;
        btn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, margin, 0, 0);
        [self.containView addSubview:btn];
        _addBtn = btn;
    }
    return _addBtn;
}
#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self setupConTentView];
    [self setupTextField];
    [self setupTags];
}

- (void)setupConTentView
{
    UIView *containView = [[UIView alloc] init];
    
    containView.backgroundColor = [UIColor redColor];
    containView.y = 64 + tagMargin;
    containView.x = tagMargin;
    containView.width = self.view.width - 2 * tagMargin;
    containView.height = self.view.height - containView.y -  tagMargin;
    [self.view addSubview:containView];
    self.containView = containView;
    
}

- (void)setupTags
{
    for (int i = 0; i < self.tags.count; i++) {
        self.textfield.text = self.tags[i];
        [self addBtnClick];
    }
}
-(void)setupTextField
{
    WLTagTextField *textfield =[[WLTagTextField alloc] init];
    [textfield sizeToFit];
    textfield.delegate =self;
    [self.containView addSubview:textfield];
    
    __weak typeof(self) __self = self;
    textfield.deleteBackLetter = ^{
        WLLog(@"66");
        if (__self.textfield.hasText) return ;
            [self deleteTagBtn:[__self.tagBtns lastObject]];
        
        
    };
    [textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [textfield becomeFirstResponder];
    self.textfield = textfield;
}
- (void)setupNavView
{
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
}

- (void)done
{
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (UIButton *btn  in self.tagBtns) {
        [arrM addObject:btn.currentTitle];
    }
    WLLog(@"arrM = %@",arrM);
    
    
    NSArray *array = [self.tagBtns valueForKey:@"currentTitle"];
    WLLog(@"array = %@",array);
    
    self.returnBlock == nil?:self.returnBlock(array);
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - 按钮点击事件
- (void)addBtnClick
{
    if (self.tagBtns.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    WLLogFunc;
    WLTagButton *addTagBtn = [WLTagButton buttonWithType:UIButtonTypeCustom];
    [addTagBtn setTitle:self.textfield.text forState:UIControlStateNormal];
    [addTagBtn addTarget:self action:@selector(deleteTagBtn:) forControlEvents:UIControlEventTouchUpInside];

    [self.containView addSubview:addTagBtn];
    addTagBtn.height = self.textfield.height;
    [self.tagBtns addObject:addTagBtn];
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagBtnFrame];
    }];
     self.textfield.text = nil;
     self.addBtn.hidden = YES;
    
}


- (void)deleteTagBtn:(UIButton *)button
{
    [button removeFromSuperview];
    [self.tagBtns removeObject:button];
    [UIView animateWithDuration:0.25 animations:^{
         [self updateTagBtnFrame];
    }];
   
}

#pragma mark - 更新TagButton的Frame
- (void)updateTagBtnFrame
{
    for (int i = 0; i < self.tagBtns.count; i++) {
        WLTagButton *btn = self.tagBtns[i];
        if (i == 0) {
            btn.x = 0;
            btn.y = 0;
        }else{
            WLTagButton *lastBtn = self.tagBtns[i - 1];
            CGFloat lastBtnX =  CGRectGetMaxX(lastBtn.frame) + tagMargin;
            CGFloat lastBtnW = lastBtn.width;
            if (lastBtnW < self.containView.width -lastBtnX) {
                btn.x = lastBtnX;
                btn.y = lastBtn.y;
            }else{
                btn.x = 0;
                btn.y = CGRectGetMaxY(lastBtn.frame)+tagMargin;
            }
        }
    }
    
    WLTagButton *lastBtn  = self.tagBtns.lastObject;
    
    CGFloat leftWidth = self.containView.width - CGRectGetMaxX(lastBtn.frame);
    if (leftWidth >= [self textFieldWidth]) {
        self.textfield.x = CGRectGetMaxX(lastBtn.frame) + tagMargin;
        self.textfield.y = lastBtn.y;
    }else{
        self.textfield.x = 0;
        self.textfield.y = CGRectGetMaxY(lastBtn.frame);
    }
 
}

#pragma mark - 监听textfield文字改变
- (void)textChange:(UITextField *)field
{
    if (field.hasText) {
        self.addBtn.hidden = NO;
        self.addBtn.y = CGRectGetMaxY(field.frame) + tagMargin;
        [self.addBtn setTitle:[NSString stringWithFormat:@"添加标签:%@",field.text] forState:UIControlStateNormal];
        NSString *textStr = field.text;
        NSUInteger len = textStr.length;
        NSString *textLetter = [textStr substringFromIndex:len - 1];
        WLLog(@"textLetter == %@",textLetter);
        if ([textLetter isEqualToString:@","] && len > 1) {
            
            self.textfield.text = [textStr substringToIndex:len-1];
            [self addBtnClick];
        }
        
       
    }else{
        self.addBtn.hidden = YES;
    }
     [self updateTagBtnFrame];
}
#pragma mark - 计算textfield文字的宽度
- (CGFloat)textFieldWidth
{
    CGFloat width = [self.textfield.text sizeWithAttributes:@{NSFontAttributeName:
                                                         self.textfield.font}].width;
    return MAX(100, width);
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
     [self addBtnClick];
    return true;
}


@end
