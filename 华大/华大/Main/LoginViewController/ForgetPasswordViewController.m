//
//  ForgetPasswordViewController.m
//  华大
//
//  Created by 隆大佶 on 2016/9/28.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "AppDelegate.h"
@interface ForgetPasswordViewController ()

@property(nonatomic,strong)UITextField *phone;
@property(nonatomic,strong)UITextField *code;
@property(nonatomic,strong)UITextField *password;
@property(nonatomic,strong)UITextField *passwordAgain;

@property(nonatomic,strong)UIButton *sendCode;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self ;
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNav];
    [self initUI];

}

-(void)initNav{
    UIButton *bakcMian = [UIButton buttonWithType:UIButtonTypeCustom];
    bakcMian.frame = CGRectMake(0, 0, 23, 23);
    [bakcMian setBackgroundImage:[UIImage imageNamed:@"返回按钮2"] forState:UIControlStateNormal];
    [bakcMian addTarget:self action:@selector(dissmissVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bakcMian];
    
    
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 45, 45);
    [right setImage:[UIImage imageNamed:@"ld-you"] forState:UIControlStateNormal];
    right.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [right addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
}
//返回
- (void) dissmissVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backToHome{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //回到首页界面
    tempAppDelegate.tabbarVC.selectedIndex = 2;
    [tempAppDelegate.LeftSlideVC closeLeftViewWithAnimated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)initUI{
    CGRect frame1 =  CGRectMake(8, 64+20, kScreenWidth-16, 40);
    self.phone = [self returnTextFieldWithHeadImage:@"dl-手机" placeholder:@"请输入手机号" frame:frame1 index:10];
    [self.view addSubview:self.phone];
    
    CGRect frame2 =  CGRectMake(8, 64+20+60, kScreenWidth-16, 40);
    self.code = [self returnTextFieldWithHeadImage:@"dl-验证码" placeholder:@"请输入验证码" frame:frame2 index:10];
    [self.view addSubview:self.code];
    
    CGRect frame3 =  CGRectMake(8, 64+20+60*2, kScreenWidth-16, 40);
    self.password = [self returnTextFieldWithHeadImage:@"dl-密码" placeholder:@"请输入密码" frame:frame3 index:10];
    [self.view addSubview:self.password];
    
    CGRect frame4 =  CGRectMake(8, 64+20+60*3, kScreenWidth-16, 40);
    self.passwordAgain = [self returnTextFieldWithHeadImage:@"dl-密码" placeholder:@"确认密码" frame:frame4 index:10];
    [self.view addSubview:self.passwordAgain];
    
    
    self.sendCode = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendCode.frame = CGRectMake(KScreenWidth-16-80,5,80, 30);
    self.sendCode.titleLabel.font = [UIFont systemFontOfSize:13];
    self.sendCode.layer.cornerRadius = 5;
    self.sendCode.layer.masksToBounds = YES;
    [self.sendCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.sendCode setBackgroundImage:[UIImage imageWithColor:KColorMainGreen] forState:UIControlStateNormal];
    [self.sendCode addTarget:self action:@selector(sendCodeA:) forControlEvents:UIControlEventTouchUpInside];
    [self.phone addSubview:self.sendCode];

    
    
    UIButton *password = [UIButton buttonWithType:UIButtonTypeCustom];
    password.frame = CGRectMake(KScreenWidth*0.1,CGRectGetMaxY(frame4) + 50,KScreenWidth*0.8, 40);
    password.titleLabel.font = [UIFont systemFontOfSize:16];
    password.layer.cornerRadius = 5;
    password.layer.masksToBounds = YES;
    [password setTitle:@"完成" forState:UIControlStateNormal];
    [password setBackgroundImage:[UIImage imageWithColor:KColorMainGreen] forState:UIControlStateNormal];
    [password addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:password];

}


-(UITextField *)returnTextFieldWithHeadImage:(NSString*)headImage placeholder:(NSString *)placeholder
                                       frame:(CGRect)frame index:(NSInteger)index
{
    
  
    UITextField *textField = [[UITextField alloc]init];
    textField.frame = frame;
//    textField.backgroundColor = [UIColor redColor];
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:16];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor = [UIColor blackColor];
    textField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    textField.font = [UIFont systemFontOfSize:16];
    
    
    UIImageView *headImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:headImage]];
    headImage1.contentMode = UIViewContentModeCenter;
    headImage1.frame = CGRectMake(0, 0, 32, 30);
    textField.leftView = headImage1;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *line2 = [[UIView alloc]init];
    line2.frame = CGRectMake(0, CGRectGetHeight(textField.frame)-1, CGRectGetWidth(textField.frame), 1);
    line2.backgroundColor = KColor(213, 213, 213);
    [textField addSubview:line2];
  
    return textField;
}

//重写self.view的方法，开始点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
     //重写方法的时候要注意一个问题
    [super touchesBegan:touches withEvent:event];
    //结束编辑，隐藏键盘
    [self.view endEditing:YES];

}
-(void)sendCodeA:(UIButton *)sender{
}
-(void)forgetPassword:(UIButton *)sender{
    
}
@end
