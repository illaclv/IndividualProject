//
//  NewsCommentTableViewCell.m
//  华大
//
//  Created by 隆大佶 on 16/9/20.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "NewsCommentTableViewCell.h"

@interface NewsCommentTableViewCell ()


@property(nonatomic,strong)UIView *cellbackgroundView;

@property(nonatomic,strong)UIButton *zanButton;

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *commentLabel;
@property(nonatomic,strong)UILabel *numberLabel;

@end


@implementation NewsCommentTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.contentView.backgroundColor = KColor(232, 240, 238);

        self.cellbackgroundView = [[UIView alloc]init];
        self.cellbackgroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.cellbackgroundView];
        
 
        
        self.zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.zanButton setImage:[UIImage imageNamed:@"iconfont-pl-dianzan-1"] forState:UIControlStateNormal];
        [self.zanButton setImage:[UIImage imageNamed:@"iconfont-pl-dianzan"] forState:UIControlStateSelected];
        self.zanButton.selected = NO;
        self.zanButton.frame = CGRectMake(15, 10, 25, 25);
        [self.zanButton addTarget:self action:@selector(zanAction:) forControlEvents:UIControlEventTouchUpInside];

        [self.cellbackgroundView addSubview:self.zanButton];

        self.commentLabel = [[UILabel alloc]init];
        self.commentLabel.font = [UIFont systemFontOfSize:14];
        self.commentLabel.textColor = KColor(121, 121, 121);
        self.commentLabel.numberOfLines = 0;

        [self.cellbackgroundView addSubview:self.commentLabel];
        
        self.numberLabel = [[UILabel alloc]init];
        self.numberLabel.font = [UIFont systemFontOfSize:14];
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        self.numberLabel.textColor = KColor(121, 121, 121);
        [self.cellbackgroundView addSubview:self.numberLabel];
        
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textColor = KColorMainGreen;
        self.titleLabel.numberOfLines = 2;
        [self.titleLabel sizeToFit];
        [self.cellbackgroundView addSubview:self.titleLabel];
        
        
    }
    return self;
}



-(void)setModel:(NewsCommentModel *)model{
    
    if (_model!=model) {
        _model=model;
    }
    if ([model.comment_praise isEqual:@(1)]) {
        self.zanButton.selected = YES;
    }
    self.commentLabel.text=[NSString stringWithFormat:@"评论%@",_model.comment_text];
    self.numberLabel.text=_model.comment_praise;
    self.titleLabel.text=_model.comment_name;
    
    
    
    
    
}

-(void)layoutSubviews{
    
    
    CGFloat width = self.size.width-16;
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX( self.zanButton.frame)+5, 10, width-CGRectGetMaxX( self.zanButton.frame), 25);
    self.numberLabel.frame = CGRectMake(15, 35, 25, 25);

    CGFloat height = [self sizeWithText:_model.comment_text font:[UIFont systemFontOfSize:14] maxW:width-40].height;
    self.commentLabel.frame = CGRectMake(40, 35, width-40, MAX(25, height));
    
    
    self.cellbackgroundView.frame = CGRectMake(8, 8, KScreenWidth-16, 35+ MAX(25, height));

 
}

// 字符串高度的计算
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, 10000);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(void)zanAction:(UIButton *)sender{
    NSString  *indexUrl = @"http://next.gouaixin.com/jiekou.php?m=Home&c=Index&a=commentpraise";
    
    NSDictionary *user =  [[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.newsID forKey:@"news_id"];
    [dic setValue:self.model.ID forKey:@"comment_id"];
    [dic setValue:[user objectForKey:@"uid"] forKey:@"user_id"];

    
    //获得请求地址`
    //提交地址和参数
    [GetData requestURL:indexUrl
             httpMethod:@"POST"
                 params:dic
                   file:nil
                success:^(id data) {
                    self.zanButton.selected = YES;

                    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.window];
                    [self.window addSubview:HUD];
                    HUD.labelText = @"点赞成功";
                    HUD.labelFont = [UIFont systemFontOfSize:14];
                    HUD.mode = MBProgressHUDModeText;
                    [HUD showAnimated:YES
                  whileExecutingBlock:^{
                      sleep(1);
                  }
                      completionBlock:^{
                          [HUD removeFromSuperview];
                      }];
                 }
                   fail:^(NSError *error) {
                       MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.window];
                       [self.window addSubview:HUD];
                       HUD.labelText = @"网络请求失败";
                       HUD.labelFont = [UIFont systemFontOfSize:14];
                       HUD.mode = MBProgressHUDModeText;
                       [HUD showAnimated:YES
                     whileExecutingBlock:^{
                         sleep(1);
                     }
                         completionBlock:^{
                             [HUD removeFromSuperview];
                         }];

                    }];
    

}
@end
