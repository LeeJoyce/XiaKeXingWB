//
//  XiaKeIntrestedTVC.m
//  XiaKeXing
//
//  Created by JOY on 17/5/19.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "XiaKeInterestedTVC.h"
#import "XiaKeMainCell.h"

@interface XiaKeInterestedTVC ()<UITextFieldDelegate>

@property (strong, nonatomic)NSMutableArray *arr;
@property (strong, nonatomic)NSString *say;

@end

@implementation XiaKeInterestedTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XiaKeMainCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    self.title = @"我的趣事";
    self.tableView.estimatedRowHeight = 50;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.arr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"myRelease"] mutableCopy];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XiaKeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setTestWithDict:self.arr[indexPath.row]];
    cell.deleteBtn.hidden = NO;
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteRelease:) forControlEvents:UIControlEventTouchUpInside];
    [cell.commeont addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.say = textField.text;
    return YES;
}

- (void)commentClick {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"评论" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"我想说点什么...";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
    }];
    
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"评论" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.say.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"不能发送空评论"];
        }else [SVProgressHUD showSuccessWithStatus:@"评论成功"];
    }];
    [alert addAction:act];
    [alert addAction:act1];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}


- (void)deleteRelease:(UIButton *)btn {
    [self.arr removeObjectAtIndex:btn.tag];
    [[NSUserDefaults standardUserDefaults] setObject:self.arr forKey:@"myRelease"];
    [self.tableView reloadData];
}


@end
