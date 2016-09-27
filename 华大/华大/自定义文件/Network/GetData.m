//
//  GetData.m
//  静态文件demo
//
//  Created by 隆大佶 on 16/3/23.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "GetData.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"


@implementation GetData



+ (void)requestURL:(NSString *)requestURL
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)parmas
              file:(NSDictionary *)files
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail
{
    
    

 
    
    //1.构造操作对象管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2.设置解析格式，默认json
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    //3.判断网络状况
//    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
//    [netManager startMonitoring];  //开始监听
//    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
//        if (status == AFNetworkReachabilityStatusNotReachable)
//        {
//            //showAlert
////            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络链接错误,请检查网络链接" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil]show];
//         
//        
//        }else if (status == AFNetworkReachabilityStatusUnknown){
//            NSLog(@"未知网络");
//        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
//            NSLog(@"WiFi");
//        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
//            NSLog(@"手机网络");
//        }
//    }];
    
    
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    
    // 4.get请求
    if ([[method uppercaseString] isEqualToString:@"GET"]) {
        
        
        [manager GET:requestURL
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 
                 if (success != nil)
                 {
                     success(responseObject);
                     NSLog (@"%@",responseObject);

                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
                 
                 
                 if (fail != nil) {
                     fail(error);
                     NSLog (@"%@",error);
                 }
             }];
        
        
        // 5.post请求不带文件 和post带文件
    }else if ([[method uppercaseString] isEqualToString:@"POST"]) {
        
        
        if (files == nil) {
            
            
            [manager POST:requestURL
               parameters:parmas
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      
                      
                      if (success) {
                          NSLog (@"%@",responseObject);

                          success(responseObject);

                      }
                      
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      
                      
                      if (fail) {
                          fail(error);
                      }
                      
                  }];
            
        } else {
            
            [manager POST:requestURL
               parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                   
                   
                   for (id key in files) {
                       
                       id value = files[key];
                       
                       
                       
                       [formData appendPartWithFileData:value
                                                   name:key
                                               fileName:@"header.png"
                                               mimeType:@"image/png"];
                   }
                   
               } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   if (success) {
                       success(responseObject);
                   }
                   
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   
                   if (fail) {
                       fail(error);
                   }
                   
               }];
        }
        
    }
    
    
}



@end
