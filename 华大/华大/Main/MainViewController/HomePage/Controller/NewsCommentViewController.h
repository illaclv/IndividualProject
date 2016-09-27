//
//  NewsCommentViewController.h
//  华大
//
//  Created by 隆大佶 on 16/9/20.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "BaseviewController.h"

@interface NewsCommentViewController : BaseviewController
@property(nonatomic,copy) NSString *newsID;

@end
/*
 

 发送评论接口
 接口请求地址
 http://next.gouaixin.com/jiekou.php?m=Home&c=Index&a=commentadd
 请求方式：post
 请求参数：
 news_id 新闻id
 comment_text 评论内容
 comment_name 评论人昵称
 user_id 评论人id
 
 返回值：
 
 
 
 评论点赞接口
 接口请求地址
 http://next.gouaixin.com/jiekou.php?m=Home&c=Index&a=commentpraise
 请求方式：post
 请求参数：
 news_id 新闻id
 comment_id 评论id
 user_id 点赞人id
 
 返回值：
 
*/
