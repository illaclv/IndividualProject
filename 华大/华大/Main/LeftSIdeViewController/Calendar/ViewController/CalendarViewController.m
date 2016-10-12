//
//  CalendarViewController.m
//  华大
//
//  Created by 隆大佶 on 2016/9/28.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *mainScrollerView;
@property (nonatomic,strong)UIWebView *webView;



@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"校历";
//    [self initUI];
    
    
    
    //http://next.gouaixin.com/jiekou.php?m=Home&c=Xiaoli&a=index
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://next.gouaixin.com/jiekou.php?m=Home&c=Xiaoli&a=index"]];
    [self.view addSubview: _webView];
    [_webView loadRequest:request];
}
//-(void)initUI{
//    UIView *a = [[UIView alloc]init];
//    a.frame = CGRectMake(0, 64, KScreenWidth , 44);
//    a.backgroundColor = [UIColor redColor];
//    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [self.view addSubview:a];
//
//    
//    UIView *line = [[UIView alloc]init];
//    line.tag = 101;
//    line.backgroundColor= [UIColor whiteColor];
//    line.frame = CGRectMake(0, 43, KScreenWidth, 1);
//    [a addSubview:line];
//    
//    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [but1 setTitle:@"第一学期" forState:UIControlStateNormal];
//    but1.tag = 50;
//    [but1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    //    but1.titleLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
//    but1.titleLabel.font = [UIFont systemFontOfSize:18];
//    but1.frame = CGRectMake(0, 0,KScreenWidth*0.5, 44);
//    [but1 addTarget:self action:@selector(changeHeadMark:) forControlEvents:UIControlEventTouchUpInside];
//    [a addSubview:but1];
//    
//    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [but2 setTitle:@"第二学期" forState:UIControlStateNormal];
//    //    but2.titleLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
//    but2.titleLabel.font = [UIFont systemFontOfSize:18];
//    [but2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    but2.tag = 51;
//    [but2 addTarget:self action:@selector(changeHeadMark:) forControlEvents:UIControlEventTouchUpInside];
//    but2.frame = CGRectMake(KScreenWidth*0.5, 0,KScreenWidth*0.5, 44);
//    [a addSubview:but2];
//    
//    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.mainScrollerView = [[UIScrollView alloc]init];
//    self.mainScrollerView.backgroundColor = [UIColor greenColor];
//    self.mainScrollerView.contentSize = CGSizeMake(KScreenWidth * 2, KScreenHeight - 49 );
//    self.mainScrollerView.frame = CGRectMake(0, 64+45, KScreenWidth, KScreenHeight - 49);
//    self.mainScrollerView.pagingEnabled = YES;
//    self.mainScrollerView.bounces = NO;
//    self.mainScrollerView.delegate = self;
//    //不显示滚动条
//    self.mainScrollerView.showsHorizontalScrollIndicator = NO;
//    self.mainScrollerView.showsVerticalScrollIndicator = NO;
//    [self.view addSubview:self.mainScrollerView];
//    
//    
//
//    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 49)];
//    image1.image = [UIImage imageNamed:@"欢迎页"];
//    [self.mainScrollerView addSubview:image1];
//    
//    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth, 0, KScreenWidth, KScreenHeight - 49)];
//    image2.image = [UIImage imageNamed:@"欢迎页"];
//    [self.mainScrollerView addSubview:image2];
//}
//
//
//-(void)changeHeadMark:(UIButton *)sender{
//    UIView *line = [self.navigationItem.titleView viewWithTag:101];
//    if (sender.tag == 50) {
//        [UIView animateWithDuration:0.3 animations:^{
//            [self.mainScrollerView setContentOffset:CGPointMake(0, 0)];
//            line.frame = CGRectMake(0.25 * KScreenWidth - 60, 41, 45, 3);
//            
//        }];
//        
//        
//    }else if (sender.tag == 51){
//        [UIView animateWithDuration:0.3 animations:^{
//            line.frame = CGRectMake(0.25 * KScreenWidth +  19, 41, 45, 3);
//            [self.mainScrollerView setContentOffset:CGPointMake(KScreenWidth, 0)];
//            
//        }];
//    }
//    
//}
//#pragma mark - 完成拖拽 改变线条
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if(scrollView == self.mainScrollerView){
//        int index = (scrollView.contentOffset.x) / scrollView.frame.size.width ;
//        UIView *line = [self.navigationItem.titleView viewWithTag:101];
//        if (index == 0) {
//            [UIView animateWithDuration:0.2 animations:^{
//                
//                line.frame = CGRectMake(0.25 * KScreenWidth - 60, 41, 45, 3);
//            }];
//            
//        }else if (index == 1){
//            [UIView animateWithDuration:0.2 animations:^{
//                
//                line.frame = CGRectMake(0.25 * KScreenWidth +  19, 41, 45, 3);
//            }];
//            
//        }
//    }
//}


@end
