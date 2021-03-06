//
//  XiaKeMainPage.m
//  XiaKeXing
//
//  Created by JOY on 17/5/19.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "XiaKeMainPage.h"
#import "XiaKeMainCell.h"
#import "SearchResultController.h"


@interface XiaKeMainPage ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UISearchBar *search;
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) NSMutableArray *jsonArr;
@property (strong, nonatomic) NSMutableArray *myArr;
@property (strong, nonatomic) NSString *say;

@end

@implementation XiaKeMainPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self setUpViews];
}

#pragma mark - baseSet 
- (void)setUpViews {
    self.view.backgroundColor = ZYWhite;
    [self.view addSubview:self.search];
    [self.view addSubview:self.table];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.myArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"myRelease"] mutableCopy];
    [self.table reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jsonArr.count + self.myArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XiaKeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tips"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
       [cell.commeont addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.row < self.myArr.count) {
        [cell setTestWithDict:self.myArr[indexPath.row]];
    }else {
        [cell setTestWithDict:self.jsonArr[indexPath.row - self.myArr.count]];
    }
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


#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_search resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    SearchResultController *result = [[SearchResultController alloc] init];
    result.searchText = searchBar.text;
    [self.navigationController pushViewController:result animated:YES];
}


#pragma mark - lazy
- (UISearchBar *)search {
    if (_search == nil) {
        _search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.zy_width, 36)];
        _search.delegate = self;
        _search.showsCancelButton = true;
        [_search setPlaceholder:@"请输入想搜索的景点名称"];
        _search.delegate = self;
    }
    return _search;
}

- (UITableView *)table {
    if (_table == nil) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.search.frame), self.view.zy_width, self.view.zy_higth - 44 - CGRectGetMaxY(self.search.frame))];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = ZYGray(200);
        [_table registerNib:[UINib nibWithNibName:NSStringFromClass([XiaKeMainCell class]) bundle:nil] forCellReuseIdentifier:@"tips"];
        _table.estimatedRowHeight = 50;
    }
    return _table;
}

- (NSMutableArray *)jsonArr {
    if (_jsonArr == nil) {
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"demo1" ofType:@"json"];
        NSData *jData = [[NSData alloc] initWithContentsOfFile:filePath];
        NSError *error;
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:jData options:kNilOptions error:&error];
        _jsonArr = [jsonObject mutableCopy];
    }
    return _jsonArr;
}


@end
