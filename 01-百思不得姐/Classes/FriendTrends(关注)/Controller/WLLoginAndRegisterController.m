//
//  WLLoginAndRegisterController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/24.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLLoginAndRegisterController.h"

@interface WLLoginAndRegisterController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeftConstant;

@end

@implementation WLLoginAndRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    
    //通过属性设置占位文字的样式
//    NSMutableAttributedString *attrPt = [[NSMutableAttributedString alloc] initWithString:@"手机号"];
//    NSMutableDictionary *arrtDict = [NSMutableDictionary dictionary];
//    arrtDict[NSForegroundColorAttributeName] = [UIColor redColor];
//    [attrPt setAttributes:arrtDict range:NSMakeRange(0, 1)];
//    self.phoneField.attributedPlaceholder = attrPt;
    
    //    self.loginBtn.layer.cornerRadius = 5;
    //    self.loginBtn.layer.masksToBounds = YES;
}
- (IBAction)loginAndRegisterClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.loginLeftConstant.constant == 0) {
         self.loginLeftConstant.constant = -self.view.width;
        [sender setTitle:@"点击登录?" forState:UIControlStateNormal];
    }else{
         self.loginLeftConstant.constant = 0;
        [sender setTitle:@"点击注册？" forState:UIControlStateNormal];

    }
//    self.loginLeftConstant.constant = -self.view.width;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginClick:(id)sender {
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)exitClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)dealloc
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
@end
