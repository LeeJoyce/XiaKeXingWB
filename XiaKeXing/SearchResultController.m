//
//  SearchResultController.m
//  XiaKeXing
//
//  Created by wangzhongyi on 17/5/21.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "SearchResultController.h"
#import "ScenicModel.h"
#import "ScenicKindsCell.h"
#import "WebViewController.h"
#import "NullView.h"
#import <MJExtension/MJExtension.h>
@interface SearchResultController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *jsonArray;
@property (nonatomic, strong) NSArray <ScenicModel *>*scenicArray;
@property (nonatomic, strong) NSMutableArray <ScenicModel *>*resultArray;
@end

@implementation SearchResultController
static NSString * animalCellID = @"animalCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"\"%@\"的搜索结果", self.searchText];
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
}


- (void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    
    for (ScenicModel *model in self.scenicArray) {
        if ([model.name containsString:searchText]) {
            [self.resultArray addObject:model];
        }
    }
    
    [self.tableView reloadData];
    
    if (self.resultArray.count == 0) {
        NullView *null = [NullView nullView];
        null.frame = self.view.frame;
        [self.view insertSubview:null atIndex:1];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScenicKindsCell *cell = [tableView dequeueReusableCellWithIdentifier:animalCellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.model = self.resultArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *wevVC = [[WebViewController alloc] init];
    ScenicModel *model = self.resultArray[indexPath.row];
    wevVC.navTitle = model.name;
    wevVC.url = model.detail;
    [self.navigationController pushViewController:wevVC animated:YES];
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

- (NSArray<ScenicModel *> *)scenicArray
{
    if (!_scenicArray) {
        _scenicArray = [ScenicModel mj_objectArrayWithKeyValuesArray:self.jsonArray];
    }
    return _scenicArray;
}

- (NSMutableArray<ScenicModel *> *)resultArray
{
    if (!_resultArray) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

@end
