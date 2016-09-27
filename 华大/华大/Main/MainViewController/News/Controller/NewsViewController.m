//
//  NewsViewController.m
//  华大
//
//  Created by 隆大佶 on 16/9/9.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "HomePageModel.h"

#import "NewsDetailViewController.h"
@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property (strong, nonatomic)  NSMutableArray *mainArray;
@property(assign,nonatomic) NSInteger page;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
}
-(void)initTableView{
    
    self.tableview = [[UITableView alloc] init];
    self.tableview.frame = CGRectMake(0, 0, self.view.frame.size.width, KScreenHeight-49);
    self.tableview.dataSource = self;
    self.tableview.delegate  = self;
    self.tableview.rowHeight = 200;
    self.tableview.backgroundColor = KColor(232, 240, 238);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];

    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = NO;
    // 隐藏状态
    header.stateLabel.hidden =NO;
    // 设置普通状态的动画图片
    // [header setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    // [header setImages:pullingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    //    [header setImages:refreshingImages2 forState:MJRefreshStateRefreshing];
    // 设置header
    _tableview.mj_header = header;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.refreshingTitleHidden = NO;
    //    [footer setTitle:@" " forState:MJRefreshStateIdle];
    // 设置刷新图片
    //    [footer setImages:refreshingImages2 forState:MJRefreshStateRefreshing];
    // 设置尾部
    _tableview.mj_footer = footer;
    
    [_tableview.mj_header beginRefreshing];

}

//刷新数据
-(void)loadNewData{
    
  
  
    self.page = 1;
    [self.mainArray removeAllObjects];
    [_tableview reloadData];
    
    NSString  *indexUrl = @"http://next.gouaixin.com/jiekou.php?m=Home&c=Index&a=newlist";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.page] forKey:@"page"];
    //获得请求地址`
    //提交地址和参数
    [GetData requestURL:indexUrl
             httpMethod:@"POST"
                 params:dic
                   file:nil
                success:^(id data) {
                    NSArray *array = [HomePageModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
                    //
                    if(array.count > 0){
                        //请求到数据
                        
                        [self.mainArray addObjectsFromArray:array];
                        [_tableview reloadData];
                    }else{
                        
                    }
                    
                    [_tableview.mj_header endRefreshing];
                }
                   fail:^(NSError *error) {
                    [_tableview.mj_header endRefreshing];
                }];
    

    
}
//加载更多
-(void)loadMoreData{
    
    
    self.page++;
    NSString  *indexUrl = @"http://next.gouaixin.com/jiekou.php?m=Home&c=Index&a=newlist";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.page] forKey:@"page"];
    //获得请求地址`
    //提交地址和参数
    [GetData requestURL:indexUrl
             httpMethod:@"POST"
                 params:dic
                   file:nil
                success:^(id data) {
                    NSArray *array = [HomePageModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
                    
                    
                    if(array.count > 0){
                        //请求到数据
                        
                        [self.mainArray addObjectsFromArray:array];
                        [_tableview reloadData];
                    }else{
                        
                    }
                    
                    [_tableview.mj_footer endRefreshing];
                    
                }
                   fail:^(NSError *error) {
                       [_tableview.mj_footer endRefreshing];
                   }];
    
}

#pragma mark ---- UItableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell == nil) {
    cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.mainArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HomePageModel *model = self.mainArray[indexPath.row];

    NewsDetailViewController *news = [[NewsDetailViewController alloc]init];
    news.newsID = model.newid;
    news.hidesBottomBarWhenPushed = YES;    //用来隐藏标签栏
    [self.navigationController pushViewController:news animated:YES];
}

-(NSMutableArray *)mainArray{
    if (!_mainArray) {
        _mainArray = [NSMutableArray array];
    }
    return _mainArray;
}

@end
