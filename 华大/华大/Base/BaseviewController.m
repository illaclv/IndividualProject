//
//  BaseviewController.m
//  shangxinda
//
//  Created by cmcc on 16/5/31.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseviewController.h"
#import "AppDelegate.h"

@interface BaseviewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseviewController

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

 
//    [self.navigationController.navigationBar alphaNavigationBarView:[[UIColor whiteColor] colorWithAlphaComponent:1]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self ;
 
    if (self.navigationController.viewControllers.count > 1) {
        

        //用图片创建item
        UIImage *image =[UIImage imageNamed:@"返回按钮"];
        //用图片最原始的模式
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIBarButtonItem *imageItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonPressed:)];
        self.navigationItem.leftBarButtonItem = imageItem ;
        //关闭侧滑
        [self setPanEnabled:NO];

    }  else{
        //主界面的导航栏
        
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.frame = CGRectMake(0, 0, 32, 32);
        [menuBtn setBackgroundImage:[UIImage imageNamed:@"index_menu"] forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    
        UIButton *menuBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn2.frame = CGRectMake(0, 0, 90, 45);
//        [menuBtn2 setBackgroundImage:[UIImage imageNamed:@"华大"] forState:UIControlStateNormal];
        [menuBtn2 setImage:[UIImage imageNamed:@"华大"] forState:UIControlStateNormal];
        menuBtn2.userInteractionEnabled = NO;
        menuBtn2.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -28);
         self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn2];
        //打开侧滑
        [self setPanEnabled:YES];
    }
    
    
}





//重写self.view的方法，开始点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"开始触摸");
    UITouch *touch = [touches anyObject];
    NSLog(@"touch = %@",touch.view);
    //重写方法的时候要注意一个问题
    [super touchesBegan:touches withEvent:event];
    //结束编辑，隐藏键盘
    [self.view endEditing:YES];
    
}
- (void)backBarButtonPressed:(id)sender {
    [self.navigationController  popViewControllerAnimated:YES];
}


//打开侧边栏
- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftViewWithAnimated:NO];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftViewWithAnimated:NO];
    }
}


//开启、关闭侧滑
- (void)setPanEnabled:(BOOL)pan
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:pan];
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    NSLog(@"viewWillDisappear");
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear");
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
//}



@end
