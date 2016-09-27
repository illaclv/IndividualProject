//
//  AppDelegate.h
//  华大
//
//  Created by 隆大佶 on 16/9/9.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//1111  fff

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "TabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
//@property (strong, nonatomic) UINavigationController *mainNavigationController;
@property (strong, nonatomic) TabBarViewController *tabbarVC;

@end

