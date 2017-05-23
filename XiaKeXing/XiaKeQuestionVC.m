//
//  XiaKeQuestionVC.m
//  XiaKeXing
//
//  Created by JOY on 17/5/19.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "XiaKeQuestionVC.h"
#import "XiaKeAskVC.h"
#import "XiaKeAnswerVC.h"

@interface XiaKeQuestionVC ()

@end

@implementation XiaKeQuestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的提问";
}

- (IBAction)askClick:(id)sender {
    [self.navigationController pushViewController:[[XiaKeAskVC alloc] init] animated:YES];
}
- (IBAction)askedClick:(id)sender {
    [self.navigationController pushViewController:[[XiaKeAskVC alloc] init] animated:YES];
}
- (IBAction)addressClick:(id)sender {
    [self.navigationController pushViewController:[[XiaKeAnswerVC alloc] init] animated:YES];
}
- (IBAction)addressedClick:(id)sender {
      [self.navigationController pushViewController:[[XiaKeAnswerVC alloc] init] animated:YES];
}
- (IBAction)sensicClick:(id)sender {
      [self.navigationController pushViewController:[[XiaKeAnswerVC alloc] init] animated:YES];
}
- (IBAction)sensicedClick:(id)sender {
      [self.navigationController pushViewController:[[XiaKeAnswerVC alloc] init] animated:YES];
}
- (IBAction)what:(id)sender {
      [self.navigationController pushViewController:[[XiaKeAnswerVC alloc] init] animated:YES];
}

- (IBAction)whtaede:(id)sender {
      [self.navigationController pushViewController:[[XiaKeAnswerVC alloc] init] animated:YES];
}


@end
