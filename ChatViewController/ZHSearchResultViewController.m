//
//  SearchResultViewController.m
//  ChatViewController
//
//  Created by ZhiHua on 16/8/7.
//  Copyright © 2016年 ZhiHua. All rights reserved.
//

#import "ZHSearchResultViewController.h"

@interface ZHSearchResultViewController () <UITableViewDelegate,UITableViewDataSource>


@end

@implementation ZHSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    
}

+ (UISearchController *)searchControllerWithDelegate:(id<SearchResultViewControllerDelegate>)delegate {
    
    ZHSearchResultViewController *resultViewController = [[ZHSearchResultViewController alloc] init];
    
    resultViewController.delegate = delegate;
    
    UISearchController *searchVC = [[UISearchController alloc] initWithSearchResultsController:resultViewController];
    
    searchVC.searchResultsUpdater = resultViewController;
    searchVC.searchBar.placeholder = @"搜索";
    searchVC.searchBar.delegate = resultViewController;
    
    return searchVC;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

#pragma mark - SearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    searchBar.showsCancelButton = YES;
    
    UIButton *button = [searchBar valueForKey:@"cancelButton"];
    
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTintColor:[UIColor orangeColor]];
    
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.text = nil;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self.delegate searchResultViewController:self searchBar:searchBar textDidChange:searchText];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.delegate searchResultViewController:self searchBarSearchButtonClicked:searchBar];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.delegate searchResultViewController:self tableView:tableView numberOfRowsInSection:section];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.delegate searchResultViewController:self tableView:tableView cellForRowAtIndexPath:indexPath];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.delegate searchResultViewController:self tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate searchResultViewController:self tableView:tableView didSelectRowAtIndexPath:indexPath];
   
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Getter & Setter 
- (UITableView *)tableView {
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds)) style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)dealloc {
    NSLog(@"SearchResultViewController dealloc");
}

@end
