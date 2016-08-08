//
//  ViewController.m
//  ChatViewController
//
//  Created by ZhiHua on 16/8/7.
//  Copyright © 2016年 ZhiHua. All rights reserved.
//

#import "ViewController.h"
#import "ZHSearchResultViewController.h"

static NSString *const reuse_id = @"reuse_id";
static NSString *const search_reuse_id = @"search_reuse_id";

@interface ViewController () <SearchResultViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSMutableArray *resultArray;

@property (nonatomic,strong) UISearchController *searchControl;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuse_id];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置搜索条
    self.searchControl = [ZHSearchResultViewController searchControllerWithDelegate:self];
    
    self.tableView.tableHeaderView = self.searchControl.searchBar;
    
    //生成测试数据
    self.dataSource = [NSMutableArray array];
    
    for (int i = 1; i<30; i++)
    {
        [self.dataSource addObject:[NSString stringWithFormat:@"我的测试数据%d",i]];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse_id];
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
    
}

#pragma mark - SearchResultViewControllerDelegate
- (CGFloat)searchResultViewController:(ZHSearchResultViewController *)searchVC tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArray.count;
}

//TableViewCell
- (UITableViewCell *)searchResultViewController:(ZHSearchResultViewController *)searchVC tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:search_reuse_id];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:search_reuse_id];
    
    cell.textLabel.text = self.resultArray[indexPath.row];
    
    return cell;
}

//Cell的高度
- (CGFloat)searchResultViewController:(ZHSearchResultViewController *)searchVC tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)searchResultViewController:(ZHSearchResultViewController *)searchVC tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击了---》%@",self.resultArray[indexPath.row]);
    
}

//搜索条发生改变
- (void)searchResultViewController:(ZHSearchResultViewController *)searchVC searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    self.resultArray = [NSMutableArray array];
    
    for (NSString *text in self.dataSource)
    {
        if ([text containsString:searchBar.text])
        {
            [self.resultArray addObject:text];
        }
    }
    
    //重新刷新数据
    [searchVC.tableView reloadData];
}

//搜索按钮的点击
- (void)searchResultViewController:(ZHSearchResultViewController *)searchVC searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

- (void)dealloc {
    NSLog(@"ViewController has dealloc!");
}


@end
