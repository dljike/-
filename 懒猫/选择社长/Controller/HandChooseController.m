//
//  HandChooseController.m
//  懒猫
//
//  Created by jike on 15/9/15.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "HandChooseController.h"
#import "Base.h"
#import "CityTableViewCell.h"
#import "LazyCatViewController.h"
#import "AFNetworkHandler.h"


@interface HandChooseController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UIView *leftView;
@property (nonatomic, retain) UIView *rightView;
@property (nonatomic, retain) UITableView *leftTableView;
@property (nonatomic, retain) UITableView *rightTableView;
@property (nonatomic, retain) NSMutableArray *cityArr;
@property (nonatomic, retain) NSMutableArray *cityNextArr;


@end

@implementation HandChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择社长";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO; // 导航不透明
    // 导航栏返回按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftButton.backgroundColor = [UIColor whiteColor];
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    leftButton.adjustsImageWhenHighlighted = NO;
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:leftButton];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, SCREEN_HEIGHT)];
    self.leftView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.leftView];
    
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(110, 0, SCREEN_WIDTH - 110, SCREEN_HEIGHT)];
    self.rightView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.rightView];
    
    
    [self createTableView];
    
    [self getData];
    
}

- (void)getData
{
   
    NSString *url = @"http://mtest.ivpin.com//WPT-OpenAPI?control=CityCommon&action=AllCity";
    
    [AFNetworkHandler GETWithAFNByURL:url completion:^(id result) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic = result;
        self.cityArr = [NSMutableArray array];
        self.cityArr = [dic objectForKey:@"citys"];
        
        [self.leftTableView reloadData];
    }];
    
}
#pragma mark - 创建tableView
- (void)createTableView
{
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 110, SCREEN_HEIGHT - 110) style:UITableViewStylePlain];
    self.leftTableView.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];
    self.leftTableView.tag = 1000;
    self.leftTableView.rowHeight = 50;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.leftTableView];
    
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(110, 0, SCREEN_WIDTH - 110, SCREEN_HEIGHT - 110) style:UITableViewStylePlain];
    self.rightTableView.tag = 2000;
    self.rightTableView.rowHeight = 50;
    
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    [self.view addSubview:self.rightTableView];
    // 去除多余的cell
    [self setExtraCellLineHidden:self.rightTableView];
    
}

#pragma mark - cell个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 1000) {
        return self.cityArr.count;
    }else{
        return self.cityNextArr.count;
    }
    return 10;
}

#pragma mark - cell显示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1000) {
        CityTableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:@"left"];
        if (!leftCell) {
            leftCell = [[CityTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"left"];
        }
        leftCell.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];
        // 选中背景颜色
        leftCell.selectedBackgroundView = [[UIView alloc] initWithFrame:leftCell.frame];
        leftCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
        leftCell.cityLable.text = [self.cityArr[indexPath.item] objectForKey:@"name"];
//        leftCell.selectionStyle = UITableViewCellSelectionStyleDefault;
        // 选中后的字体颜色
        leftCell.cityLable.highlightedTextColor = [UIColor orangeColor];
        return leftCell;
    }else if (tableView.tag == 2000){
        UITableViewCell *rightCell = [tableView dequeueReusableCellWithIdentifier:@"right"];
        if (!rightCell) {
            rightCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"rightCell"];
        }
         rightCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // 箭头
        rightCell.textLabel.text = [self.cityNextArr[indexPath.item] objectForKey:@"name"];
        return rightCell;
    }
    return nil;
}

#pragma mark - cell的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1000) {
        
       NSString *cityid = [self.cityArr[indexPath.item] objectForKey:@"cityid"];
        NSString *url = [NSString stringWithFormat:@"http://mtest.ivpin.com//WPT-OpenAPI?control= CityCommon&action= CityID&cityid=%@",cityid];
        
        [AFNetworkHandler GETWithAFNByURL:url completion:^(id result) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic = result;
            self.cityNextArr = [NSMutableArray array];
            self.cityNextArr = [dic objectForKey:@"citys"];
            [self.rightTableView reloadData];
        }];
        
        // 跳到社区界面
    }else if (tableView.tag == 2000){
        
//     NSLog(@"---------%@",[self.cityNextArr[indexPath.item] objectForKey:@"cityid"]);
    
        LazyCatViewController *lazy = [[LazyCatViewController alloc] init];
        lazy.cityId = [self.cityNextArr[indexPath.item] objectForKey:@"cityid"];
        [self.navigationController pushViewController:lazy animated:YES];
    }
    
}


// 返回按钮
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 隐藏多余的tableView
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
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
