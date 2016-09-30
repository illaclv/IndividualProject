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
    //关闭  侧滑打开侧边栏
    [self setPanEnabled:NO];
    //右侧按钮 返回主界面
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 45, 45);
    [right setImage:[UIImage imageNamed:@"ld-you"] forState:UIControlStateNormal];
    right.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [right addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
}
//重写self.view的方法，开始点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    //重写方法的时候要注意一个问题
    [super touchesBegan:touches withEvent:event];
    //结束编辑，隐藏键盘
    [self.view endEditing:YES];
    
}

//返回上一层界面
- (void)backBarButtonPressed:(id)sender {
    [self.navigationController  popViewControllerAnimated:YES];
}

//返回到 主界面
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
//跳转到主界面
-(void)backToHome{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //回到首页界面
    tempAppDelegate.tabbarVC.selectedIndex = 2;
    [tempAppDelegate.LeftSlideVC closeLeftViewWithAnimated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
