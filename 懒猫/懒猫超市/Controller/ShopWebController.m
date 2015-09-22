//
//  ShopWebController.m
//  懒猫
//
//  Created by jike on 15/9/18.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "ShopWebController.h"
#import "UINavigationController+SGProgress.h"

@interface ShopWebController ()<UIWebViewDelegate>

@property(nonatomic, getter = isCanceled) BOOL canceled;
@end

@implementation ShopWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO; // 导航不透明
    [self.navigationController showSGProgressWithDuration:3]; // 进度条
    
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
    [webView.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 110, 0)];
    // 边缘弹动效果
    [webView.scrollView setBounces:NO];
    // 加载请求
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    // 添加父视图
    [self.view addSubview:webView];
    
}

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
