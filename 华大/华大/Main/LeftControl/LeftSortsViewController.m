//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
#import "otherViewController.h"

#import "TabBarViewController.h"
#import "TestViewController.h"

//登陆
#import "LoginViewController.h"
//校历
#import "CalendarViewController.h"
//证书
#import "CertificateViewController.h"
//黄页
#import "YellowPagesViewController.h"
//证明
#import "ProveViewController.h"
//搜索
#import "SearchViewController.h"
//办事大厅
#import "ServiceHallViewController.h"
//设置
#import "SettingViewController.h"
//学生查询
#import "StudentsQueryViewController.h"
//请假
#import "LeaveViewController.h"





#define KColor(a,b,c)  [UIColor colorWithRed:a/255.f green:b/255.f blue:c/255.f alpha:1.0]

@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *mainDataArray;
@property(nonatomic,strong)UIButton *enterButton;

@end

@implementation LeftSortsViewController
//判断登陆状态
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSDictionary *user = [[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    if (user == nil) {
        NSLog(@"未登录");
        self.mainDataArray = [NSArray arrayWithObjects:@"通知",@"新闻",@"查询课表",@"校历",@"请假",@"黄页",@"证明", nil];
        [self.tableview reloadData];
    }else{
        NSString *utype = [user objectForKey:@"utype"];
        if ([utype isEqual:@(1)]) {
            self.mainDataArray = [NSArray arrayWithObjects:@"通知",@"新闻",@"查询课表",@"校历",@"请假",@"黄页",@"证明", nil];
            [self.tableview reloadData];
            
        }else if ([utype isEqual:@(2)]){
            self.mainDataArray = [NSArray arrayWithObjects:@"通知",@"新闻",@"查询课表",@"校历",@"请假",@"黄页",@"证明", nil];
            [self.tableview reloadData];
        }else if ([utype isEqual:@(3)]){
            self.mainDataArray = [NSArray arrayWithObjects:@"通知",@"新闻",@"查询课表",@"校历",@"请假",@"黄页",@"证明", nil];
            [self.tableview reloadData];
        }
    }
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"user"] == nil) {
        //未登录
        self.enterButton = [self addButonWithIndex:1 title:@"登陆" imageName:@"iconfont-denglu"tag:101] ;
    }else{
        //已登陆
        self.enterButton = [self addButonWithIndex:1 title:@"退出" imageName:@"iconfont-denglu"tag:103] ;
        
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColorMainGreen;
    
    UITableView *tableview = [[UITableView alloc] init];
    tableview.frame = CGRectMake(0, 0, self.view.frame.size.width, KScreenHeight-49);
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    self.tableview = tableview;

    [self initButtomView];
}

-(void)initButtomView{
    UIView *buttom = [[UIView alloc]init];
    buttom.frame = CGRectMake(0, kScreenHeight - 49, self.view.bounds.size.width, 49);
    buttom.backgroundColor = [UIColor colorWithRed:51/215.f green:51/255.f blue:51/255.f alpha:1.0];
    [self.view addSubview:buttom];
    //灰色的线
    [self returnLineWithFram:CGRectMake(0, 0, self.view.bounds.size.width, 1) superView:buttom color:KColor(130, 130, 130)];
    //三个按钮

    [buttom addSubview:[self addButonWithIndex:0 title:@"设置" imageName:@"iconfont-shezhi"tag:100] ];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"user"] == nil) {
        //未登录
        self.enterButton = [self addButonWithIndex:1 title:@"登陆" imageName:@"iconfont-denglu"tag:101] ;
    }else{
        //已登陆
        self.enterButton = [self addButonWithIndex:1 title:@"退出" imageName:@"iconfont-denglu"tag:103] ;

    }

    [buttom addSubview:self.enterButton];
    [buttom addSubview:[self addButonWithIndex:2 title:@"搜索" imageName:@"iconfont-sousuo" tag:102]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
//    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
//    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    cell.textLabel.text = self.mainDataArray[indexPath.row];
    [self returnLineWithFram:CGRectMake(0, 43, self.view.bounds.size.width, 1) superView:cell.contentView color:KColor(28, 91, 149)];

        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

 
    
 
 
 


    
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC openLeftViewWithAnimated:NO];//打开左侧抽屉
    
    //防止越界
    if (self.mainDataArray.count > indexPath.row) {
        if([self.mainDataArray[indexPath.row] isEqualToString:@"通知"]){
            //跳转通知界面
            [self changeTabbarIndex:0];
        }
        if([self.mainDataArray[indexPath.row] isEqualToString:@"新闻"]){
            //跳转新闻界面
            [self changeTabbarIndex:1];
        }
        if([self.mainDataArray[indexPath.row] isEqualToString:@"校历"]){
            //跳转校历界面
            CalendarViewController *test=[[CalendarViewController alloc]init];
            UINavigationController *nacv = [[UINavigationController alloc]initWithRootViewController:test];
            nacv.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nacv animated:YES completion:nil];
        }
        if([self.mainDataArray[indexPath.row] isEqualToString:@"证书"]){
            //跳转证书界面
            CertificateViewController *test=[[CertificateViewController alloc]init];
            UINavigationController *nacv = [[UINavigationController alloc]initWithRootViewController:test];
            nacv.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nacv animated:YES completion:nil];
        }if([self.mainDataArray[indexPath.row] isEqualToString:@"黄页"]){
            //跳黄页界面
            YellowPagesViewController *test=[[YellowPagesViewController alloc]init];
            UINavigationController *nacv = [[UINavigationController alloc]initWithRootViewController:test];
            nacv.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nacv animated:YES completion:nil];
        }if([self.mainDataArray[indexPath.row] isEqualToString:@"证明"]){
            //跳转证明界面
            ProveViewController *test=[[ProveViewController alloc]init];
            UINavigationController *nacv = [[UINavigationController alloc]initWithRootViewController:test];
            nacv.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nacv animated:YES completion:nil];
        }
        if([self.mainDataArray[indexPath.row] isEqualToString:@"搜索"]){
            //跳转搜索界面
            SearchViewController *test=[[SearchViewController alloc]init];
            UINavigationController *nacv = [[UINavigationController alloc]initWithRootViewController:test];
            nacv.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nacv animated:YES completion:nil];
        }
        if([self.mainDataArray[indexPath.row] isEqualToString:@"办事大厅"]){
            //跳转办事大厅界面
            ServiceHallViewController *test=[[ServiceHallViewController alloc]init];
            UINavigationController *nacv = [[UINavigationController alloc]initWithRootViewController:test];
            nacv.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nacv animated:YES completion:nil];
        }
        if([self.mainDataArray[indexPath.row] isEqualToString:@"学生查询"]){
            //跳转学生查询界面
            StudentsQueryViewController *test=[[StudentsQueryViewController alloc]init];
            UINavigationController *nacv = [[UINavigationController alloc]initWithRootViewController:test];
            nacv.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nacv animated:YES completion:nil];
        } if([self.mainDataArray[indexPath.row] isEqualToString:@"请假"]){
            //跳转新请假界面
            LeaveViewController *test=[[LeaveViewController alloc]init];
            UINavigationController *nacv = [[UINavigationController alloc]initWithRootViewController:test];
            nacv.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nacv animated:YES completion:nil];
        }
        
        
    }
    
    
    
  
//    if (indexPath.row==1) {
//        TestViewController *test=[[TestViewController alloc]init];
//        UINavigationController *nacv = [[UINavigationController alloc]initWithRootViewController:test];
//        nacv.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self presentViewController:nacv animated:YES completion:nil];
//    }else{
//
//
//    otherViewController *vc = [[otherViewController alloc] init];
//    //    [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
//    UINavigationController *nacv = [[UINavigationController alloc]initWithRootViewController:vc];
//    nacv.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:nacv animated:YES completion:nil];
//
//    }
    
    
    

}


//头视图
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 90;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 100)];
    
   
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"华大"]];
    imageView.frame = CGRectMake(30,30, 51, 51);
    [view addSubview:imageView];
    return view;
}


-(UIView *)returnLineWithFram:(CGRect)frame superView:(UIView *)view color:(UIColor*)color{
    UIView *line = [[UIView alloc]init];
    line.frame = frame;
    line.backgroundColor = color;
    [view addSubview:line];
    return line;
}

-(UIButton*)addButonWithIndex:(NSInteger)Index title:(NSString*)title imageName:(NSString*)imageNmae tag:(NSInteger)tag
{
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];;
    btn3.frame = CGRectMake( 30 + Index * 60 , 0 ,49 , 49);
    btn3.tag = tag;
    [btn3 addTarget:self action:@selector(btnpressed:) forControlEvents:UIControlEventTouchUpInside];

    
    UIImageView *imageview3 = [[UIImageView alloc]initWithFrame:CGRectMake(12, 5, 25, 25)];
    imageview3.image = [UIImage imageNamed:imageNmae] ;
    [btn3 addSubview:imageview3];
//    imageview3.userInteractionEnabled  =NO;

    
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(0 ,49-14, 49, 12)];
    lable3.text = title;
    lable3.textColor = KColor(102, 102, 102);
    lable3.font = [UIFont systemFontOfSize:12];
    lable3.textAlignment = NSTextAlignmentCenter;
    [btn3 addSubview:lable3];
    return btn3;
}
-(void)btnpressed:(UIButton *)sender{
    if (sender.tag == 100) {
        NSLog(@"设置");
    }else if (sender.tag == 101){
        NSLog(@"登陆");
        LoginViewController *login = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:nav animated:NO completion:nil];
    }else if (sender.tag == 102){
        NSLog(@"搜索");
    }else if (sender.tag == 103){
        NSLog(@"退出");
    }
}
#pragma mark - 跳转到通知、新闻界面

-(void)changeTabbarIndex:(NSInteger)index{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //回到首页界面
    tempAppDelegate.tabbarVC.selectedIndex = index;
    [tempAppDelegate.LeftSlideVC closeLeftViewWithAnimated:YES];
    
}

@end
