//
//  LazyCatViewController.m
//  懒猫
//
//  Created by jike on 15/9/15.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "LazyCatViewController.h"
#import "ChoosePresidentViewController.h"
#import "Base.h"
#import "AFNetworkHandler.h"


@interface LazyCatViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *dataArr;

@end

@implementation LazyCatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainURL = @"http://mtest.ivpin.com//WPT-OpenAPI?";
    
    // 导航栏返回按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftButton.backgroundColor = [UIColor whiteColor];
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    leftButton.adjustsImageWhenHighlighted = NO;
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:leftButton];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 110)];
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // 去掉多余的cell
    [self setExtraCellLineHidden:self.tableView];
    
    // 获取数据
    [self getData];
    
}

- (void)getData
{
    NSString *cityid = self.cityId; // cityid
    NSString *url = [NSString stringWithFormat:@"%@control=ShopCommon&action=CityID&cityid=%@&sign=",self.mainURL,cityid];
    
    [AFNetworkHandler GETWithAFNByURL:url completion:^(id result) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic = result;
        self.dataArr = [NSArray array];
        self.dataArr = [dic objectForKey:@"shops"];
       
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.dataArr forKey:@"dataArr"];
        
        [self.tableView reloadData];
        
        
    }];
    
    
}


#pragma mark - cell的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
#pragma mark - cell显示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // 箭头
    cell.textLabel.text = [self.dataArr[indexPath.item] objectForKey:@"name"];
    
    return cell;
}

#pragma mark - cell的点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

//---------------------------------------------------------------------
    // －－－－－－－－－－ 通知中心 －－－－－－－－－－
    // 发送post
    // 参数1: 通知名
    // 参数2: 发送通知时可传递一个参数
    // 参数3: 多参使用字典传递
    
    
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color" object:[UIColor redColor] userInfo:@{@"name":[self.dataArr[indexPath.item] objectForKey:@"name"],@"x":[self.dataArr[indexPath.item] objectForKey:@"x"],@"y":[self.dataArr[indexPath.item] objectForKey:@"y"],@"shopuser":[self.dataArr[indexPath.item] objectForKey:@"shopuser"]}];
    
    // shopuser存入plist文件中
    NSString *path = [[NSBundle mainBundle] pathForResource:@"userList" ofType:@"plist"];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
//    NSLog(@"==============%@",data);
    
    [data setObject:[self.dataArr[indexPath.item] objectForKey:@"shopuser"] forKey:@"name"];
    [data writeToFile:path atomically:YES];
    
//    NSLog(@"=================%@",data);
    

    
    
    
//    NSLog(@"-=-=-=-=-=-=-=-=%@", [self.dataArr[indexPath.item] objectForKey:@"shopuser"]);
    
    
    
    // 向前页面传值
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:NO];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
 //--------------------------------------------------------------------
//    NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
//    NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
//    for(NSString* key in [dictionary allKeys]){
//        [userDefatluts removeObjectForKey:key];
//        [userDefatluts synchronize];
//    };
//    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *tempArr = [NSDictionary dictionaryWithDictionary:self.dataArr[indexPath.item]];
////    tempArr = self.dataArr[indexPath.item];
//    [userDefaults setObject:tempArr forKey:@"dataArr"];
//    [userDefaults synchronize];
    
//    NSLog(@"%ld",indexPath.item);
}

// 隐藏多余的tableView
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}


#pragma mark - 返回按钮
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
