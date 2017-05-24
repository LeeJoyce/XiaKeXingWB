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
@property (strong, nonatomic)NSMutableArray *arr;

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
    return cell;
}

- (void)deleteRelease:(UIButton *)btn {
    NSLog(@"%zd",btn.tag);
    NSLog(@"%zd",self.arr.count);
    [self.arr removeObjectAtIndex:btn.tag];
    [[NSUserDefaults standardUserDefaults] setObject:self.arr forKey:@"myRelease"];
    [self.tableView reloadData];
}


@end
