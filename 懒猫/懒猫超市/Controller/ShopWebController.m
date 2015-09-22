//
//  ShopWebController.m
//  懒猫
//
//  Created by jike on 15/9/18.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "ShopWebController.h"
#import "UINavigationController+SGProgress.h"
#import "Base.h"

@interface ShopWebController ()<UIWebViewDelegate>

@property(nonatomic, getter = isCanceled) BOOL canceled;

@property (nonatomic, retain) UIView *lowerView;
@property (nonatomic, retain) UIButton *subtraction;
@property (nonatomic, retain) UIButton *addition;
@property (nonatomic, retain) UILabel *count;
@property (nonatomic, retain) NSString *countNum;// 商品数量
@property (nonatomic, retain) UILabel *carLable;



@end

@implementation ShopWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO; // 导航不透明
    [self.navigationController showSGProgressWithDuration:3]; // 进度条

    self.navigationItem.title = self.titleName;
    // 导航右边搜索按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    rightButton.backgroundColor = [UIColor whiteColor];
    rightButton.adjustsImageWhenHighlighted = NO;
    [rightButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.view addSubview:rightButton];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;


    self.countNum = @"0";
    
    // 导航栏返回按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftButton.backgroundColor = [UIColor whiteColor];
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    leftButton.adjustsImageWhenHighlighted = NO;
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:leftButton];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 创建视图
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    // 设置webView上的scrollView边界预留
    [webView.scrollView setContentInset:UIEdgeInsetsMake(0, 0, SCREEN_HEIGHT * 0.09, 0)];
    // 边缘弹动效果
    [webView.scrollView setBounces:NO];
    // 加载请求
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    // 添加父视图
    [self.view addSubview:webView];
    
    
    
    self.lowerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 170, SCREEN_WIDTH, 100)];
    self.lowerView.backgroundColor = [UIColor whiteColor];
    [webView addSubview:self.lowerView];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 100, 20)];
    lable.text = @"添加商品:";
    [self.lowerView addSubview:lable];
    
    
    // 减号button
    self.subtraction = [[UIButton alloc] init];
    self.subtraction.frame = CGRectMake(100, 15, 25, 25);
    //    [self.subtraction setTitle:@"-" forState:UIControlStateNormal];
    [self.subtraction setImage:[UIImage imageNamed:@"subtraction"] forState:UIControlStateNormal];
    [self.subtraction addTarget:self action:@selector(subtractionAction) forControlEvents:UIControlEventTouchUpInside];
    [self.subtraction setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.subtraction.layer.borderWidth = 1;
    self.subtraction.layer.borderColor = [UIColor grayColor].CGColor;
    self.subtraction.backgroundColor = [UIColor whiteColor];
    self.subtraction.layer.cornerRadius = 25 / 2;
    self.subtraction.clipsToBounds = YES;
    [self.lowerView addSubview:self.subtraction];
    
    
    // 加号button
    self.addition = [[UIButton alloc] init];
    self.addition.frame = CGRectMake(160, 15, 25, 25);
    //    [self.addition setTitle:@"+" forState:UIControlStateNormal];
    [self.addition setImage:[UIImage imageNamed:@"addition"] forState:UIControlStateNormal];
    [self.addition setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.addition addTarget:self action:@selector(additionAction) forControlEvents:UIControlEventTouchUpInside];
    self.addition.layer.borderWidth = 1;
    self.addition.layer.borderColor = [UIColor grayColor].CGColor;
    self.addition.backgroundColor = [UIColor whiteColor];
    self.addition.layer.cornerRadius = 25 / 2;
    self.addition.clipsToBounds = YES;
    [self.lowerView addSubview:self.addition];
    
    // 数量
    self.count = [[UILabel alloc]init];
    self.count.frame = CGRectMake(120, 20, 50, 20);
//        self.count.backgroundColor = [UIColor blackColor];
    self.count.textAlignment = NSTextAlignmentCenter;
    self.count.text = self.countNum;
    [self.lowerView addSubview:self.count];
    
    UIButton *shopCar = [[UIButton alloc] initWithFrame:CGRectMake(300, 5, 50, 50)];
    [shopCar setImage:[UIImage imageNamed:@"shopcar"] forState:UIControlStateNormal];
    shopCar.layer.cornerRadius = 25;
    shopCar.backgroundColor = [UIColor orangeColor];
    shopCar.clipsToBounds = YES;
    [self.lowerView addSubview:shopCar];
    
    
    self.carLable = [[UILabel alloc] initWithFrame:CGRectMake(330, 5, 20, 20)];
    self.carLable.layer.cornerRadius = 10;
    self.carLable.clipsToBounds = YES;
    self.carLable.text = self.countNum;
    self.carLable.backgroundColor = [UIColor redColor];
    self.carLable.textColor = [UIColor whiteColor];
    self.carLable.textAlignment = NSTextAlignmentCenter;
    [self.lowerView addSubview:self.carLable];
    
    
}

#warning 分享按钮
-(void)shareAction
{
    
}


#warning 加号方法
-(void)additionAction
{
    NSInteger tempNum = [self.countNum integerValue];
    tempNum ++;
    self.countNum = [NSString stringWithFormat:@"%ld",tempNum];
    self.count.text = self.countNum;
    self.carLable.text = self.countNum;
}

#warning 减号按钮
-(void)subtractionAction
{
    NSInteger tempNum = [self.countNum integerValue];
    if (tempNum > 0) {
        tempNum --;
        self.countNum = [NSString stringWithFormat:@"%ld",tempNum];
        self.count.text = self.countNum;
        self.carLable.text = self.countNum;
    }
    
}


#warning 返回按钮
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

// webView加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.canceled = YES;
    [self.navigationController cancelSGProgress];
    
    
}
- (void)showSGProgressWithDuration:(float)duration andTintColor:(UIColor *)tintColor andTitle:(NSString *)title
{
    tintColor = [UIColor orangeColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
