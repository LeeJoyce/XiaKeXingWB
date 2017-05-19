//
//  XiaKeNav.m
//  XiaKeXing
//
//  Created by JOY on 17/5/19.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "XiaKeNav.h"

@interface XiaKeNav ()<UIGestureRecognizerDelegate>

@end

@implementation XiaKeNav

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.barTintColor = ZYWhite;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backBtn sizeToFit];
        [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back:(UIViewController *)viewController {
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}


@end
