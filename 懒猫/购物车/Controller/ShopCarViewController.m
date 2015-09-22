//
//  ShopCarViewController.m
//  懒猫
//
//  Created by jike on 15/9/11.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "ShopCarViewController.h"

@interface ShopCarViewController ()



@end

@implementation ShopCarViewController


#pragma mark - 通知中心初始化
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 通知的注册一般放在初始化中
//        ShopCarViewController *shop = [[ShopCarViewController alloc] init];
        [self creatNotificationCenter];
    }
    return self;
}


#pragma mark - NotificationCenter 通知中心
- (void)creatNotificationCenter
{
#warning 1. 创建视图中心
    // 通知中心单例(在任何地方 使用的通知中心都是同一个)
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    // 注册通知 给对象添加观察者
    // 参数1: 通知的观察值
    // 参数2: 注册的方法
    // 参数3: 通知名(对应通知的标志)
    // 参数4: nil
    [center addObserver:self selector:@selector(changeColor:) name:@"collectNum" object:nil];
    
    
}
#warning 3. 收到post通知后 执行注册好的方法
-(void)changeColor:(NSNotification *)noti
{
    // 通知名
//    NSLog(@"通知名%@",noti.name);
    // 传递的参数
//    NSLog(@"传递的参数%@",noti.object);
    // 传递的字典
//    NSLog(@"传递的字典%@",noti.userInfo);
    
    NSDictionary *dic = [NSDictionary dictionary];
    dic = noti.userInfo;
//    NSLog(@"===========%@",dic);
    
    if ([[dic objectForKey:@"num"] isEqualToString:@"0"]) {
        self.tabBarItem.badgeValue = nil;
    }else{
    self.tabBarItem.badgeValue = [dic objectForKey:@"num"];
    }

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO; // 导航不透明
    self.navigationItem.title = @"购物车";
    
    
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
