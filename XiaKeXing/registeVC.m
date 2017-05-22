//
//  registeVC.m
//  WiFiKeepers
//
//  Created by JOY on 16/4/25.
//  Copyright © 2016年 JOY. All rights reserved.
//

#import "registeVC.h"
#import "LoginViewC.h"
#import "XiaKeTabBar.h"

@interface registeVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *secretNumberTF;

@property (weak, nonatomic) IBOutlet UIButton *regisBtn;
@property (weak, nonatomic) UIView *bgEnableView;
@property (weak, nonatomic) IBOutlet UIButton *goToLoginBtn;

@end

@implementation registeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setUpView];
    [self textchange];
}


- (void)setNav {
    self.title = @"注册";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = ZYWhite;
//    [SVProgressHUD dismiss];
    [self removeBgView];
    [self.view endEditing:YES];
}

- (void)setUpView {
    self.regisBtn.layer.cornerRadius = 3;
    [self.secretNumberTF setSecureTextEntry:YES];
    
    [self.phoneNumberTF addTarget:self action:@selector(textchange) forControlEvents:UIControlEventEditingChanged];
    [self.secretNumberTF addTarget:self action:@selector(textchange) forControlEvents:UIControlEventEditingChanged];
}

- (void)textchange {
    self.regisBtn.enabled = self.secretNumberTF.text.length >= 6 && self.phoneNumberTF.text.length > 0;
    if (self.regisBtn.enabled == YES) {
        self.regisBtn.backgroundColor = ZYColor(32, 216, 168);
    }else self.regisBtn.backgroundColor = ZYGray(200);
}


- (IBAction)eyeClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [self.secretNumberTF setSecureTextEntry:NO];
    }else [self.secretNumberTF setSecureTextEntry:YES];
    NSString* text = self.secretNumberTF.text;
    self.secretNumberTF.text = @" ";
    self.secretNumberTF.text = text;
}

- (IBAction)regisLogin:(id)sender {
    [self AddBgEnable];
//    [SVProgressHUD showWithStatus:@"正在验证注册"];
    if ([[userTokenTool getAccont] isEqualToString: self.phoneNumberTF.text]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD showErrorWithStatus:@"已经注册过这个账号"];
            [self removeBgView];
        });
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberTF.text forKey:@"accont"];
    [[NSUserDefaults standardUserDefaults] setObject:self.secretNumberTF.text forKey:@"secret"];
    [[NSUserDefaults standardUserDefaults] setObject:@"token" forKey:@"token"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD showSuccessWithStatus:@"注册登录成功"];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[XiaKeTabBar alloc] init];
    });
}

- (void)AddBgEnable {
    UIView *bgEnableView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgEnableView.backgroundColor = ZYGray(222);
    bgEnableView.alpha = 0.6;
    self.bgEnableView = bgEnableView;
    [self.view addSubview:bgEnableView];
}

- (void)removeBgView {
    [self.bgEnableView removeFromSuperview];
}

- (IBAction)gotoLoginClick:(id)sender {
    [self.navigationController pushViewController:[[LoginViewC alloc] init] animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
