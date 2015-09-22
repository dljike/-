//
//  AppDelegate.m
//  懒猫
//
//  Created by jike on 15/9/11.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "AppDelegate.h"

#import "IndexViewController.h"
#import "ShopCarViewController.h"
#import "SupermarketViewController.h"
#import "LifeViewController.h"
#import "MyViewController.h"
#import "ChoosePresidentViewController.h"
#import "DataBase.h"


@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic, retain) UINavigationController *indexNvc;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    tabBar.tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.tabBar.barTintColor = [UIColor whiteColor];

    DataBase *data = [[DataBase alloc] init];
    [data openDB];
        [data createTable];
    // 查询数据
    NSArray *arr = [data selectInfo];

//        if (arr.count < 1) {
//        ChoosePresidentViewController *choose = [[ChoosePresidentViewController alloc] init];
//        self.indexNvc = [[UINavigationController alloc] initWithRootViewController:choose];
//        
//        choose.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[[UIImage imageNamed:@"index"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"index2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    }else{
    
        // 首页
        IndexViewController *index = [[IndexViewController alloc] init];
        
        self.indexNvc = [[UINavigationController alloc] initWithRootViewController:index];
        
        index.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[[UIImage imageNamed:@"index"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"index2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    }
   
    
   
    
    
    // 懒猫超市
    SupermarketViewController *market = [[SupermarketViewController alloc] init];
    
    UINavigationController *marketNvc = [[UINavigationController alloc] initWithRootViewController:market];
    
    market.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"懒猫超市" image:[[UIImage imageNamed:@"supermarket"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"supermarket2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 设置tabBar字体选中颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor orangeColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor, UITextAttributeTextColor,nil]forState:UIControlStateSelected];
    // 生活圈
//    LifeViewController *life = [[LifeViewController alloc] init];
//    UINavigationController *lifeNvc = [[UINavigationController alloc] initWithRootViewController:life];
//    
//    life.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"生活圈" image:[[UIImage imageNamed:@"index"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"life2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    // 购物车
    ShopCarViewController *shopCar = [[ShopCarViewController alloc] init];
    
    UINavigationController *shopCarNvc = [[UINavigationController alloc] initWithRootViewController:shopCar];
    
    shopCar.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"购物车" image:[[UIImage imageNamed:@"shop"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"shop2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
//    shopCar.tabBarItem.badgeValue = @"3";
    
    
    
    // 我的
    MyViewController *my = [[MyViewController alloc] init];
    
    UINavigationController *myNvc = [[UINavigationController alloc] initWithRootViewController:my];
    
    my.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[[UIImage imageNamed:@"my"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"my2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    // 给tabBar 添加控制器
    tabBar.viewControllers = @[self.indexNvc,marketNvc,shopCarNvc,myNvc];
    
    tabBar.delegate = self;
    
    
    // 把tabBar 设置为根视图
    self.window.rootViewController = tabBar;

    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"%ld",tabBarController.selectedIndex);
    
    // 清楚小红点
    viewController.tabBarItem.badgeValue = nil;
    
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
