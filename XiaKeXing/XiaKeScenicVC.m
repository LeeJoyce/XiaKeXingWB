//
//  XiaKeScenicVC.m
//  XiaKeXing
//
//  Created by JOY on 17/5/19.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "XiaKeScenicVC.h"
#import "ScenicKindsCell.h"
#import "ScenicModel.h"
#import "WebViewController.h"
#import "SearchResultController.h"
#import <MJExtension/MJExtension.h>
@interface XiaKeScenicVC ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <ScenicModel *>*scenicArray;
@property (nonatomic, strong) NSArray *jsonArray;
@property (strong, nonatomic) UISearchBar *search;
@end

@implementation XiaKeScenicVC
static NSString * animalCellID = @"animalCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"景点";
    
    
    self.scenicArray = [ScenicModel mj_objectArrayWithKeyValuesArray:self.jsonArray];
    [self setupTableView];
}

- (void)setupTableView
{
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    self.tableView.rowHeight = 100;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"ScenicKindsCell" bundle:nil] forCellReuseIdentifier:animalCellID];
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self setUpTableHeader];
}

- (void)setUpTableHeader
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZYScreenSize.width, 36)];
    self.search.frame = CGRectMake(0, 0, ZYScreenSize.width, 36);
    [headerView addSubview:self.search];
    self.tableView.tableHeaderView = headerView;
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.scenicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScenicKindsCell *cell = [tableView dequeueReusableCellWithIdentifier:animalCellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.model = self.scenicArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *wevVC = [[WebViewController alloc] init];
    ScenicModel *model = self.scenicArray[indexPath.row];
    wevVC.navTitle = model.name;
    wevVC.url = model.detail;
    [self.navigationController pushViewController:wevVC animated:YES];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    SearchResultController *result = [[SearchResultController alloc] init];
    result.searchText = searchBar.text;
    [self.navigationController pushViewController:result animated:YES];
}

#pragma mark - lazy
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

- (NSArray *)jsonArray
{
    if (!_jsonArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"scenic" ofType:@"txt"];
        NSError *error = nil;
        NSString *jsonStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        _jsonArray = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }
    return _jsonArray;
}

- (UISearchBar *)search {
    if (_search == nil) {
        _search = [[UISearchBar alloc] initWithFrame:CGRectZero];
        _search.delegate = self;
        _search.showsCancelButton = true;
        [_search setPlaceholder:@"请输入想搜索的景点名称"];
    }
    return _search;
}

@end
