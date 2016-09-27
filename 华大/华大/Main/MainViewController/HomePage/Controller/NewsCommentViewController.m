//
//  NewsCommentViewController.m
//  华大
//
//  Created by 隆大佶 on 16/9/20.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "NewsCommentViewController.h"
#import "NewsCommentModel.h"
#import "NewsCommentTableViewCell.h"

#import "ZYKeyboardUtil.h"

@interface NewsCommentViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property (strong, nonatomic)  NSMutableArray *mainArray;
@property(assign,nonatomic) NSInteger page;

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;
@property (strong, nonatomic) UITextView *commentTextFeild;

@end
@implementation NewsCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    [self initTableView];
    
    [self ButtomView];
    [self configKeyBoardRespond];

}


- (void)configKeyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    
    __weak NewsCommentViewController *weakSelf = self;
#pragma explain - 全自动键盘弹出/收起处理 (需调用keyboardUtil 的 adaptiveViewHandleWithController:adaptiveView:)
#pragma explain - use animateWhenKeyboardAppearBlock, animateWhenKeyboardAppearAutomaticAnimBlock will be invalid.
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.commentTextFeild, nil];
    }];
    
#pragma explain - 自定义键盘弹出处理(如配置，全自动键盘处理则失效)
#pragma explain - use animateWhenKeyboardAppearAutomaticAnimBlock, animateWhenKeyboardAppearBlock must be nil.
    
    //     [_keyboardUtil setAnimateWhenKeyboardAppearBlock:^(int appearPostIndex, CGRect keyboardRect, CGFloat keyboardHeight, CGFloat keyboardHeightIncrement) {
    //     NSLog(@"\n\n键盘弹出来第 %d 次了~  高度比上一次增加了%0.f  当前高度是:%0.f"  , appearPostIndex, keyboardHeightIncrement, keyboardHeight);
    //     //do something
    //         weakSelf.view.frame = CGRectMake(0, -keyboardHeight, KScreenWidth, KScreenHeight);
    //     }];
    
    
#pragma explain - 自定义键盘收起处理(如不配置，则默认启动自动收起处理)
#pragma explain - if not configure this Block, automatically itself.
    
    [_keyboardUtil setAnimateWhenKeyboardDisappearBlock:^(CGFloat keyboardHeight) {
        NSLog(@"\n\n键盘在收起来~  上次高度为:+%f", keyboardHeight);
        //do something
        weakSelf.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        
    }];
    
    
#pragma explain - 获取键盘信息
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
        NSLog(@"\n\n拿到键盘信息 和 ZYKeyboardUtil对象");
    }];
    
    
}

-(void)ButtomView{
    UIView *buttomView = [[UIView alloc]init];
    buttomView.frame = CGRectMake(0, KScreenHeight-58, KScreenWidth, 58);
    buttomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomView];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor colorWithRed:220/255.f green:220/255.f blue:220/255.f alpha:1.0];
    line1.frame = CGRectMake(0, 0, KScreenWidth, 1);
    [buttomView addSubview:line1];
    
 
    UITextView *textField = [[UITextView alloc]init];
    textField.frame = CGRectMake(8+44,5,KScreenWidth-8-8-44, 40);
    textField.text = @"评论";
    textField.delegate = self;
    textField.font = [UIFont systemFontOfSize:16];
    textField.textColor = [UIColor blackColor];
    textField.returnKeyType = UIReturnKeySend;
    [buttomView addSubview:textField];
    self.commentTextFeild = textField;

    UIImageView *image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"iconfont-xiaoximobanicon"];
    image.contentMode = UIViewContentModeCenter;
    image.frame = CGRectMake(8, 1, 44, 44);
    [buttomView addSubview:image];

    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1.0];
    line.frame = CGRectMake(8, 45, KScreenWidth-16, 1);
    [buttomView addSubview:line];
    
}
-(void)initTableView{
    
    self.tableview = [[UITableView alloc] init];
    self.tableview.frame = CGRectMake(0, 0, self.view.frame.size.width, KScreenHeight-58);
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
    
    NSString  *indexUrl = @"http://next.gouaixin.com/jiekou.php?m=Home&c=Index&a=commentlist";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.newsID forKey:@"news_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.page] forKey:@"currentpage"];

    
    //获得请求地址`
    //提交地址和参数
    [GetData requestURL:indexUrl
             httpMethod:@"POST"
                 params:dic
                   file:nil
                success:^(id data) {
                    NSArray *array = [NewsCommentModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
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
    NSString  *indexUrl = @"http://next.gouaixin.com/jiekou.php?m=Home&c=Index&a=commentlist";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.newsID forKey:@"news_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.page] forKey:@"currentpage"];

    //获得请求地址`
    //提交地址和参数
    [GetData requestURL:indexUrl
             httpMethod:@"POST"
                 params:dic
                   file:nil
                success:^(id data) {
                    NSArray *array = [NewsCommentModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
                    
                    
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
    NewsCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell == nil) {
        cell = [[NewsCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
        cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.mainArray[indexPath.row];
    cell.newsID = self.newsID;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCommentModel *model = self.mainArray[indexPath.row];
    CGFloat height = [self sizeWithText:model.comment_text font:[UIFont systemFontOfSize:14] maxW:KScreenWidth-16-40].height;

    return 35+ MAX(25, height)+16;
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    NewsDetailViewController *news = [[NewsDetailViewController alloc]init];
//    news.hidesBottomBarWhenPushed = YES;    //用来隐藏标签栏
//    [self.navigationController pushViewController:news animated:YES];
//}

-(NSMutableArray *)mainArray{
    if (!_mainArray) {
        _mainArray = [NSMutableArray array];
    }
    return _mainArray;
}

// 字符串高度的计算
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, 10000);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView == self.commentTextFeild && [self.commentTextFeild.text isEqualToString:@"评论"]) {
        self.commentTextFeild.text = @"";
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self.commentTextFeild resignFirstResponder];
        
        NSString  *indexUrl = @"http://next.gouaixin.com/jiekou.php?m=Home&c=Index&a=commentadd";
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:self.newsID forKey:@"news_id"];
        [dic setValue:self.commentTextFeild.text forKey:@"comment_text"];
        
        NSDictionary *user =  [[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
        if (user == nil) {
            NSLog(@"没有登录");
        }else{
//            [dic setValue:[user objectForKey:@"uid"] forKey:@"comment_name"];
            [dic setValue:[user objectForKey:@"uid"] forKey:@"user_id"];
        }

       
        
        
        //获得请求地址`
        //提交地址和参数
        [GetData requestURL:indexUrl
                 httpMethod:@"POST"
                     params:dic
                       file:nil
                    success:^(id data) {
                        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
                        [self.view addSubview:HUD];
                        HUD.labelText = @"发送成功";
                        HUD.labelFont = [UIFont systemFontOfSize:14];
                        HUD.mode = MBProgressHUDModeText;
                        [HUD showAnimated:YES
                      whileExecutingBlock:^{
                          //刷新评论
                          [_tableview.mj_header beginRefreshing];
                          sleep(1);
                      }
                          completionBlock:^{
                              [HUD removeFromSuperview];
                          }];
                    }
                       fail:^(NSError *error) {
                           MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
                           [self.view addSubview:HUD];
                           HUD.labelText = @"网络请求失败";
                           HUD.labelFont = [UIFont systemFontOfSize:14];
                           HUD.mode = MBProgressHUDModeText;
                           [HUD showAnimated:YES
                         whileExecutingBlock:^{
                             sleep(1);
                         }
                             completionBlock:^{
                                 [HUD removeFromSuperview];
                             }];
                        }];
        

        
    }
    return YES;
}

@end
