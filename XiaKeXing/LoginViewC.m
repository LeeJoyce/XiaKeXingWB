//
//  LoginVC.m
//  WiFiKeepers
//
//  Created by JOY on 16/4/25.
//  Copyright © 2016年 JOY. All rights reserved.
//

#import "LoginViewC.h"
#import "registeVC.h"
#import "XiaKeTabBar.h"

@interface LoginViewC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *secretNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic)UIView *bgEnableView;

@property (weak, nonatomic) IBOutlet UIButton *goToRegisBtn;


@end

@implementation LoginViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    self.loginBtn.layer.cornerRadius = 3;
    [self setUpText];
    [self textChange];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = ZYWhite;
    [super viewWillDisappear:animated];
    [self removeBgView];
    [SVProgressHUD dismiss];
}

- (void)setUpNav {
    self.title = @"登录";
}

- (void)setUpText {
    [self.secretNumberTF setSecureTextEntry:YES];
    [self.phoneNumberTF addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.secretNumberTF addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)textChange {
    self.loginBtn.enabled = self.phoneNumberTF.text.length >= 11 && self.secretNumberTF.text.length >= 6;
    if (self.loginBtn.enabled == YES) {
        self.loginBtn.backgroundColor = ZYColor(32, 216, 168);
    }else self.loginBtn.backgroundColor =  ZYGray(200);
}

- (IBAction)loginClick:(UIButton *)sender {
    [self AddBgEnable];
    [SVProgressHUD showWithStatus:@"正在登录"];
    if ([self.phoneNumberTF.text isEqualToString:[userTokenTool getAccont]]) {
        if ([self.secretNumberTF.text isEqualToString:[userTokenTool getSecret]]) {
            [[NSUserDefaults standardUserDefaults]setObject:@"token" forKey:@"token"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD showErrorWithStatus:@"登录成功"];
                [UIApplication sharedApplication].keyWindow.rootViewController = [[XiaKeTabBar alloc] init];
            });
        } else [SVProgressHUD showErrorWithStatus:@"密码错误"];
    } else [SVProgressHUD showErrorWithStatus:@"没有这个账号"];
    [self removeBgView];
}

- (void)AddBgEnable {
    UIView *bgEnableView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgEnableView.backgroundColor = ZYGray(222);
    bgEnableView.alpha = 0.5;
    self.bgEnableView = bgEnableView;
    [self.view addSubview:bgEnableView];
}

- (void)removeBgView {
    [self.bgEnableView removeFromSuperview];
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

- (IBAction)regisGoToClick:(id)sender {
    [self.navigationController pushViewController:[[registeVC alloc] init] animated:YES];
}

- (IBAction)forgetSecretGoTo:(id)sender {

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}




@end
