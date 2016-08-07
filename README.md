
## UISearchController的封装和使用

### 使用方法

	1、初始化
    //设置搜索条
    UISearchController *searchVC = [ZHSearchResultViewController searchControllerWithDelegate:self];
    
    self.tableView.tableHeaderView = searchVC.searchBar;

	2、设置代理属性
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



### ZHSearchResultViewController

	@interface ZHSearchResultViewController : UIViewController <UISearchBarDelegate,UISearchResultsUpdating>
	
	@property (nonatomic,strong) UITableView *tableView;
	
	//代理属性
	@property (nonatomic,weak) id<SearchResultViewControllerDelegate> delegate;
	
	//快捷创建方法
	+ (UISearchController *)searchControllerWithDelegate:(id<SearchResultViewControllerDelegate>)delegate;
	
	@end

### SearchResultViewControllerDelegate

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