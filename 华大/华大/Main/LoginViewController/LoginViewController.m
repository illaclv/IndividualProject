//
//  LoginViewController.m
//  华大
//
//  Created by 隆大佶 on 16/9/23.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ForgetPasswordViewController.h"
@interface LoginViewController()
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UITextField *passwordTextField;

@end
//【链接】{"status":{"succeed":0,"error_co
//http://next.gouaixin.com/jiekou.php?m=Home&c=User&a=login
//然后只需要传 name  和pass两个参数
@implementation LoginViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = KColorMainGreen;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self ;
    self.title = @"登陆";
    self.view.backgroundColor = [UIColor whiteColor];
    
    

    
    [self initUI];
    [self initNav];
    
    
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

-(void)initUI{
    
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"华大白"]];
    imageView.frame = CGRectMake(KScreenWidth*0.5-25,100, 51, 51);
    [self.view addSubview:imageView];
    
    UIImageView *ldbg = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"dl-bg"]];
    ldbg.frame = CGRectMake(0,kScreenHeight-KScreenWidth*0.52, KScreenWidth, KScreenWidth*0.52);
    [self.view addSubview:ldbg];
    
    UITextField *phoneTextField = [[UITextField alloc]init];
    phoneTextField.frame = CGRectMake(KScreenWidth*0.2,0.33*kScreenHeight,KScreenWidth*0.6, 40);
    phoneTextField.placeholder = @"账号";
    phoneTextField.font = [UIFont systemFontOfSize:12];
//     phoneTextField.textColor = KColo_3f_63;
//    phoneTextField.clearButtonMode = UIphoneTextFieldViewModeUnlessEditing;
    phoneTextField.layer.cornerRadius = 20;
    phoneTextField.layer.borderWidth = 1.0;
    phoneTextField.layer.borderColor =  [UIColor getColor:@"#02568b"].CGColor;
    [self.view addSubview:phoneTextField];
    self.phoneTextField = phoneTextField;
    

    UIImageView *headImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-log-lianxiren"]];
    headImage1.contentMode = UIViewContentModeCenter;
    headImage1.frame = CGRectMake(0, 0, 36, 30);
    phoneTextField.leftView = headImage1;
    phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UITextField *passwordTextField = [[UITextField alloc]init];
    passwordTextField.frame = CGRectMake(KScreenWidth*0.2,0.33*kScreenHeight+40+20,KScreenWidth*0.6, 40);
    passwordTextField.placeholder = @"账号";
    passwordTextField.font = [UIFont systemFontOfSize:12];
    //     phoneTextField.textColor = KColo_3f_63;
    //    phoneTextField.clearButtonMode = UIphoneTextFieldViewModeUnlessEditing;
    passwordTextField.layer.cornerRadius = 20;
    passwordTextField.layer.borderWidth = 1.0;
    passwordTextField.layer.borderColor =  [UIColor getColor:@"#02568b"].CGColor;
    [self.view addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    
    UIImageView *headImage2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-log-mima"]];
    headImage2.contentMode = UIViewContentModeCenter;
    headImage2.frame = CGRectMake(0, 0, 36, 30);
    passwordTextField.leftView = headImage2;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIButton *enter = [UIButton buttonWithType:UIButtonTypeCustom];
    enter.frame = CGRectMake(KScreenWidth*0.2,0.33*kScreenHeight+40+20+40+20,KScreenWidth*0.6, 40);
    enter.layer.cornerRadius = 20;
    enter.layer.masksToBounds = YES;
    [enter setBackgroundImage:[UIImage imageWithColor:[UIColor getColor:@"#02568b"]] forState:UIControlStateNormal];
    [enter setTitle:@"登陆" forState:UIControlStateNormal];
    [enter addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enter];
    
    UIButton *forget = [UIButton buttonWithType:UIButtonTypeCustom];
    forget.frame = CGRectMake(KScreenWidth*0.3,0.33*kScreenHeight+40+20+40+20+40+20,KScreenWidth*0.4, 40);    
    [forget setImage:[UIImage imageNamed:@"log-wenhao"] forState:UIControlStateNormal];
    [forget setTitle:@" 忘记密码" forState:UIControlStateNormal];
    forget.titleLabel.font = [UIFont systemFontOfSize:14];
    [forget setTitleColor:[UIColor getColor:@"#02568b"] forState:UIControlStateNormal];
    [forget addTarget:self action:@selector(forget:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forget];
    
    
    
    
 }

-(void)login:(UIButton *)sender{
    if (![self.phoneTextField.text isEqualToString:@""]  && ![self.passwordTextField.text isEqualToString:@""]) {
        NSString  *indexUrl = @"http://next.gouaixin.com/jiekou.php?m=Home&c=User&a=login";
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:self.phoneTextField.text forKey:@"name"];
        [dic setValue:self.passwordTextField.text forKey:@"password"];
        //获得请求地址`
        //提交地址和参数
        [GetData requestURL:indexUrl
                 httpMethod:@"POST"
                     params:dic
                       file:nil
                    success:^(id data) {
                        

                        NSString *aaa = data[@"status"][@"succeed"] ;
                        NSLog( @"%@",aaa);
                        if ([data[@"status"][@"succeed"] isKindOfClass:[NSNumber class]]) {
                            if ([data[@"status"][@"succeed"]   isEqual: @(1)]) {
                                NSDictionary *dataGet = [data objectForKey:@"data"];
                                NSDictionary *user = [dataGet objectForKey:@"session"];

                                [[NSUserDefaults standardUserDefaults]setObject:user forKey:@"user"];
                                //返回
                                [self dismissViewControllerAnimated:YES completion:nil];
                            }else{
                                //账号密码错误
                            }
                       

                        }else{
                            
                        }
                        
                    }
                        fail:^(NSError *error) {
                       }];
    }else{
                NSLog(@"输入账号");
    }
    
  

}
-(void)forget:(UIButton *)sender{
    ForgetPasswordViewController *forget = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
}

//返回
- (void) dissmissVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)backToHome{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //回到首页界面
    tempAppDelegate.tabbarVC.selectedIndex = 2;
    [tempAppDelegate.LeftSlideVC closeLeftViewWithAnimated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];

}
//重写self.view的方法，开始点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
     //重写方法的时候要注意一个问题
    [super touchesBegan:touches withEvent:event];
    //结束编辑，隐藏键盘
    [self.view endEditing:YES];
    
}

@end
