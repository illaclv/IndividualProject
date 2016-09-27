//
//  BaseLeftViewController.m
//  华大
//
//  Created by 隆大佶 on 16/9/10.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "BaseLeftViewController.h"
#import "AppDelegate.h"
@implementation BaseLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:18],NSForegroundColorAttributeName:KColo_lineblue}];
    //    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:KColo_lineblue}];
    
    self.view.backgroundColor = [UIColor getColor:@"#f5f5f5"];
    // 取出导航栏的线
//    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
//        NSArray *list=self.navigationController.navigationBar.subviews;
//        for (id obj in list) {
//            if ([obj isKindOfClass:[UIImageView class]]) {
//                UIImageView *imageView=(UIImageView *)obj;
//                NSArray *list2=imageView.subviews;
//                for (id obj2 in list2) {
//                    if ([obj2 isKindOfClass:[UIImageView class]]) {
//                        UIImageView *imageView2=(UIImageView *)obj2;
//                        imageView2.hidden=YES;
//                    }
//                }
//            }
//        }
//    }
    
    
//    [self.navigationController.navigationBar alphaNavigationBarView:[KColorMainGreen colorWithAlphaComponent:1]];
    self.navigationController.navigationBar.barTintColor = KColorMainGreen;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self ;
    
    if (self.navigationController.viewControllers.count > 1) {
        
        
        //用图片创建item
        UIImage *image =[UIImage imageNamed:@"返回按钮2"];
        //用图片最原始的模式
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIBarButtonItem *imageItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonPressed:)];
        self.navigationItem.leftBarButtonItem = imageItem ;
        
        
    }  else{
        //主界面的导航栏
        
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.frame = CGRectMake(0, 0, 23, 23);
        [menuBtn setBackgroundImage:[UIImage imageNamed:@"返回按钮2"] forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(dissmissVC) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    }
    //关闭侧滑
    [self setPanEnabled:NO];
    
}
//重写self.view的方法，开始点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
//    NSLog(@"touch = %@",touch.view);
    //重写方法的时候要注意一个问题
    [super touchesBegan:touches withEvent:event];
    //结束编辑，隐藏键盘
    [self.view endEditing:YES];
    
}

//返回上一层界面
- (void)backBarButtonPressed:(id)sender {
    [self.navigationController  popViewControllerAnimated:YES];
}

//打开侧边栏
- (void) dissmissVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//开启、关闭侧滑
- (void)setPanEnabled:(BOOL)pan
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:pan];
}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear");
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
//}

@end
