//
//  EditInfoViewController.m
//  XiaKeXing
//
//  Created by wangzhongyi on 17/5/21.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "EditInfoViewController.h"
#import "EditInfoCell.h"
@interface EditInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation EditInfoViewController
static NSString * editInfoCellID = @"editInfo";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑个人信息";
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"EditInfoCell" bundle:nil] forCellReuseIdentifier:editInfoCellID];
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZYScreenSize.width, 300)];
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.backgroundColor = ZYColor(76, 191, 164);
    [saveBtn setTitle:@"保    存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.frame = CGRectMake(50, 200, ZYScreenSize.width - 100, 44);
    [footerView addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = footerView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:editInfoCellID];
    [cell setSourceWithIndex:indexPath];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"编辑个人信息";
}

#pragma  mark - Private method
- (void)saveInfo
{

    [self.navigationController popViewControllerAnimated:YES];
    
    EditInfoCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell0.infoTextfield.text.length != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:cell0.infoTextfield.text forKey:KUserName];
    }

    EditInfoCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (cell1.infoTextfield.text.length != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:cell1.infoTextfield.text forKey:KUserSex];
    }

    EditInfoCell *cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if (cell2.infoTextfield.text.length !=0) {
        [[NSUserDefaults standardUserDefaults] setObject:cell2.infoTextfield.text forKey:KUserSite];
    }
    
    EditInfoCell *cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (cell3.infoTextfield.text.length != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:cell3.infoTextfield.text forKey:KUserIntroduce];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (self.saveBtnClickBlock) {
        self.saveBtnClickBlock();
    }
}

#pragma mark - lazy
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _tableView;
}

@end
