//
//  SuccessSubmitController.m
//  移动掌控
//
//  Created by 李昊泽 on 17/1/17.
//  Copyright © 2017年 dianbo. All rights reserved.
//

#import "SuccessSubmitController.h"

@interface SuccessSubmitController ()
@property (weak, nonatomic) IBOutlet UIView *btnBackView;

@end

@implementation SuccessSubmitController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"数据提交成功";
    
    _btnBackView.layer.borderWidth = 1;
    _btnBackView.layer.borderColor = ZYColor(220, 220, 220).CGColor;
    _btnBackView.layer.cornerRadius = 3;
    
}

- (IBAction)popToRoot:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)reUnload:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
