//
//  SearchResultViewController.h
//  ChatViewController
//
//  Created by ZhiHua on 16/8/7.
//  Copyright © 2016年 ZhiHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHSearchResultViewController;
@protocol SearchResultViewControllerDelegate <NSObject>

@required;
//Cell的总数
- (CGFloat)searchResultViewController:(ZHSearchResultViewController *)searchVC tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

//TableViewCell
- (UITableViewCell *)searchResultViewController:(ZHSearchResultViewController *)searchVC tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

//Cell的高度
- (CGFloat)searchResultViewController:(ZHSearchResultViewController *)searchVC tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

//Cell的点击
- (void)searchResultViewController:(ZHSearchResultViewController *)searchVC tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

//搜索条发生改变
- (void)searchResultViewController:(ZHSearchResultViewController *)searchVC searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;

//搜索按钮的点击
- (void)searchResultViewController:(ZHSearchResultViewController *)searchVC searchBarSearchButtonClicked:(UISearchBar *)searchBar;

@end

@interface ZHSearchResultViewController : UIViewController <UISearchBarDelegate,UISearchResultsUpdating>

//@property (nonatomic,strong) UISearchController *searchVC;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,weak) id<SearchResultViewControllerDelegate> delegate;

+ (UISearchController *)searchControllerWithDelegate:(id<SearchResultViewControllerDelegate>)delegate;

@end
