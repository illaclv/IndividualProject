//
//  NewsCommentTableViewCell.h
//  华大
//
//  Created by 隆大佶 on 16/9/20.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsCommentModel.h"

@interface NewsCommentTableViewCell : UITableViewCell
@property(nonatomic,strong)NewsCommentModel *model;
@property(nonatomic,copy) NSString *newsID;

@end
