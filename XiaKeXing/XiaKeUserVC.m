//
//  XiaKeUserVC.m
//  XiaKeXing
//
//  Created by JOY on 17/5/19.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "XiaKeUserVC.h"
#import "XiaKeInterestedTVC.h"
#import "XiaKeQuestionVC.h"
#import "XiaKeUserInfoVC.h"

@interface XiaKeUserVC ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *myInterested;
@property (weak, nonatomic) IBOutlet UIButton *userInfo;
@property (weak, nonatomic) IBOutlet UIButton *Question;

@end

@implementation XiaKeUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
}

- (IBAction)InterestedClick:(id)sender {
    [self.navigationController pushViewController:[[XiaKeInterestedTVC alloc] init] animated:YES];
}
- (IBAction)userInfoClick:(id)sender {
    [self.navigationController pushViewController:[[XiaKeUserInfoVC alloc] init] animated:YES];
}
- (IBAction)questionClick:(id)sender {
    [self.navigationController pushViewController:[[XiaKeQuestionVC alloc] init] animated:YES];
}

@end
