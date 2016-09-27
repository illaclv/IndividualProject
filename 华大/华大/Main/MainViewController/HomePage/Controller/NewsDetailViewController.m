//
//  NewsDetailViewController.m
//  华大
//
//  Created by 隆大佶 on 16/9/20.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsCommentViewController.h"
#import "NewsDetailModel.h"
@interface NewsDetailViewController()
@property(nonatomic,strong)NewsDetailModel *mainModel;

@property(nonatomic,strong)UIScrollView *mainScrollerView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *pensonLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)UILabel *commentLabel;


@property(nonatomic,strong)UILabel *mainLabel;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithAll];
    [self getData];
 
    [self rightButton];
    
}

#pragma mark - 右边
-(void)rightButton{
     CGFloat width = [self sizeWithText:@"(12)" font:[UIFont systemFontOfSize:12] maxW:MAXFLOAT].width;
    
    UIButton *butr = [UIButton buttonWithType:UIButtonTypeCustom];
    butr.frame = CGRectMake(0, 0, 14+width+6+3, 44);
//    butr.backgroundColor = [UIColor redColor];
    [butr addTarget:self action:@selector(xiaoxi) forControlEvents:UIControlEventTouchUpInside];
    butr.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-28 );
    
    
    UIImageView *imageview3 = [[UIImageView alloc]initWithFrame:CGRectMake(3, 14, 14, 16)];
    imageview3.image = [UIImage imageNamed:@"iconfont-xx-xiaoxi"] ;
    [butr addSubview:imageview3];
    //        imageview3.userInteractionEnabled  =NO;
    
    UILabel *lable3 = [[UILabel alloc]init];
    lable3.text = @"(0)";
    lable3.frame = CGRectMake( 3+14+3,14, width, 16);
    lable3.textColor = KColor(102, 102, 102);
    lable3.font = [UIFont systemFontOfSize:14];
    lable3.textAlignment = NSTextAlignmentCenter;
    [butr addSubview:lable3];
    self.commentLabel = lable3;
    
    

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:butr];
}

// 字符串高度的计算
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, 10000);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(void)xiaoxi{
    NewsCommentViewController *comment  = [[NewsCommentViewController alloc]init];
    comment.newsID = self.newsID;
    [self .navigationController pushViewController:comment animated:YES];
    
}

-(void)initWithAll{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.mainScrollerView = [[UIScrollView alloc]init];
    self.mainScrollerView.frame = self.view.frame;
    [self.view addSubview:self.mainScrollerView];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = KColor(1, 1, 1);
    self.titleLabel.numberOfLines = 0;
//    [self.titleLabel sizeToFit];
    [self.mainScrollerView addSubview:self.titleLabel];
    
    
    self.pensonLabel = [[UILabel alloc]init];
    self.pensonLabel.font = [UIFont systemFontOfSize:10];
    self.pensonLabel.textColor = KColor(121, 121, 121);
    [self.mainScrollerView addSubview:self.pensonLabel];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    self.timeLabel.textColor = KColor(121, 121, 121);
    [self.mainScrollerView addSubview:self.timeLabel];
    
    self.imageView = [[UIImageView alloc]init];
    [self.mainScrollerView addSubview:self.imageView];
    
    self.mainLabel = [[UILabel alloc]init];
    self.mainLabel.font = [UIFont systemFontOfSize:13];
    self.mainLabel.textColor = KColor(121, 121, 121);
    self.mainLabel.numberOfLines = 0;
    [self.mainScrollerView addSubview:self.mainLabel];
}

-(void)getData{
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    NSString  *indexUrl = @"http://next.gouaixin.com/jiekou.php?m=Home&c=Index&a=newinfo";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.newsID forKey:@"newid"];
    //获得请求地址`
    //提交地址和参数
    [GetData requestURL:indexUrl
             httpMethod:@"POST"
                 params:dic
                   file:nil
                success:^(id data) {
                    
                    self.mainModel = [NewsDetailModel mj_objectWithKeyValues:data[@"data"]];
                    [self layoutView];
                   
                }
                   fail:^(NSError *error) {
                   }];
}
-(void)layoutView{
    self.titleLabel.text = self.mainModel.newtitle;
    CGSize titleS = [self sizeWithText:self.mainModel.newtitle font:[UIFont systemFontOfSize:16] maxW:KScreenWidth-16];
    self.titleLabel.frame = CGRectMake(8, 64, KScreenWidth-16, titleS.height);
    
    
    self.pensonLabel.text = self.mainModel.bumen;
    self.pensonLabel.frame = CGRectMake(8,  CGRectGetMaxY(self.titleLabel.frame),KScreenWidth-16, 20);
    
    self.timeLabel.text = self.mainModel.shijian;
    self.timeLabel.frame = CGRectMake(8,  CGRectGetMaxY(self.pensonLabel.frame),KScreenWidth-16, 20);

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.mainModel.newimage]];
    self.imageView.frame = CGRectMake(8,  CGRectGetMaxY(self.timeLabel.frame),KScreenWidth-16, 150);
    
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.mainModel.newcontent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

    self.mainLabel.attributedText = attrStr;
    CGSize mainL = [self sizeWithText:self.mainModel.newcontent font:[UIFont systemFontOfSize:13] maxW:KScreenWidth-16];
    self.mainLabel.frame = CGRectMake(8,  CGRectGetMaxY(self.imageView.frame),KScreenWidth-16, mainL.height);
    
    self.mainScrollerView.contentSize = CGSizeMake(KScreenWidth, CGRectGetMaxY(self.mainLabel.frame));
    
    //右上角的评论数
    self.commentLabel.text = [NSString stringWithFormat:@"(%@)",self.mainModel.pinglunnum];
    
}


@end
