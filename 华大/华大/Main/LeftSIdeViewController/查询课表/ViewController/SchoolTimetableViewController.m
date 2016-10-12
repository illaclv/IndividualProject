//
//  SchoolTimetableViewController.m
//  华大
//
//  Created by 隆大佶 on 2016/10/11.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "SchoolTimetableViewController.h"

@interface SchoolTimetableViewController ()

@end
/**
 

 课表查询接口
 接口请求地址
 http://next.gouaixin.com/jiekou.php?m=Home&c=Index&a=kebiao
 请求方式：post
 请求参数：
 user_id：学生的id，也就是登陆返回的uid
 year：年
 month：月
 day：日
 返回值;：
 course_time 课程时间，例如：8:00 - 9:40
 course_name  课程名称
 
 */



@implementation SchoolTimetableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查询课表";
    [self getTimetable];
    
}

-(void)getTimetable{
    NSString  *indexUrl = @"http://next.gouaixin.com/jiekou.php?m=Home&c=Index&a=kebiao";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"" forKey:@"year"];
    [dic setValue:@"" forKey:@"month"];
    [dic setValue:@"" forKey:@"day"];
    
    NSDictionary *user =  [[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    [dic setValue: [user objectForKey:@"uid"] forKey:@"user_id"];
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
                   
                            
                        }else{
                            //账号密码错误
                        }
                        
                        
                    }else{
                        
                    }
                    
                }
                   fail:^(NSError *error) {
                   }];

}


@end
