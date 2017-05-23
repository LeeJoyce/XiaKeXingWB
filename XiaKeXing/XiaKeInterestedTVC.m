//
//  XiaKeIntrestedTVC.m
//  XiaKeXing
//
//  Created by JOY on 17/5/19.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "XiaKeInterestedTVC.h"
#import "XiaKeMainCell.h"

@interface XiaKeInterestedTVC ()

@end

@implementation XiaKeInterestedTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XiaKeMainCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    self.title = @"我的趣事";
    self.tableView.estimatedRowHeight = 50;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XiaKeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.deleteBtn.hidden = NO;
    return cell;
}



@end
