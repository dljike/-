//
//  SupermarketViewController.m
//  懒猫
//
//  Created by jike on 15/9/11.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "SupermarketViewController.h"
#import "Base.h"
#import "RightCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworkHandler.h"
#import "ShopWebController.h"
#import "LeftTableCell.h"
#import "MBProgressHUD.h"


@interface SupermarketViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, retain) UITableView *tableVew;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *numArr;
@property (nonatomic, retain) NSMutableArray *productCount;
@property (nonatomic, retain) NSMutableArray *leftdataArr;
@property (nonatomic, retain) NSMutableArray *rightdataArr;
@property (nonatomic, assign) NSInteger numOfcell; // 保存点击第几个产品 右边标题
@property (nonatomic, retain) UILabel *headLable;
@property (nonatomic, retain) UIView *rightView;
@property (nonatomic, assign) NSInteger tempHidden; // 左边view隐藏


@end

@implementation SupermarketViewController


-(void)viewWillAppear:(BOOL)animated
{

#warning 清空右边数据
//    
//    self.leftdataArr = [NSMutableArray array];
//    //#warning 创建collectionView
//    self.rightdataArr = [NSMutableArray array];
//
//    self.headLable.text = @"";
//    [self.collectionView reloadData];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
#warning 加载左边视图数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"userList" ofType:@"plist"];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    //    NSLog(@"~~~~~~~~~~~~~~%@",[data objectForKey:@"name"]);
    
    NSString *url = [NSString stringWithFormat:@"http://mtest.ivpin.com//WPT-OpenAPI?control=LCatShop&action=getLcatCategory&shopuser=%@",[data objectForKey:@"name"]];
    
    //    NSLog(@"========%@",url);
    [AFNetworkHandler GETWithAFNByURL:url completion:^(id result) {
        
        NSDictionary *tempDic = [NSDictionary dictionary];
        tempDic = result;
        self.leftdataArr = [NSMutableArray array];
        self.leftdataArr = [tempDic objectForKey:@"userCategory"];
        
        [self.tableVew reloadData];
        
        [self creatCollection];
        [self getRightData];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}
-(void)viewDidAppear:(BOOL)animated
{
    NSInteger selected = 0;
    NSIndexPath *selectedIndex = [NSIndexPath indexPathForRow:selected inSection:0];
    [self.tableVew selectRowAtIndexPath:selectedIndex animated:NO scrollPosition:UITableViewScrollPositionNone];
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO; // 导航不透明
    self.navigationItem.title = @"懒猫超市";
    // 左边view
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, SCREEN_HEIGHT)];
    leftView.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];;
    [self.view addSubview:leftView];
    // 右边view
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(120, 0, SCREEN_WIDTH - 120, SCREEN_HEIGHT)];
//    self.rightView.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];
    self.rightView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rightView];
    
#warning tableView
    self.tableVew = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120, SCREEN_HEIGHT - 100) style:UITableViewStylePlain];
    self.tableVew.dataSource = self;
    self.tableVew.delegate = self;
    self.tableVew.rowHeight = 50;
    self.tableVew.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];
    self.tableVew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [leftView addSubview:self.tableVew];
    
    // 注册tableView
    [self.tableVew registerClass:[LeftTableCell class] forCellReuseIdentifier:@"tabCell"];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getData];
    
    
}

#warning 创建collectionView
-(void)creatCollection
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH - 125, 80);
    layout.minimumLineSpacing = 1;
    layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 40);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 120, SCREEN_HEIGHT - 120) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //    self.collectionView.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.rightView addSubview:self.collectionView];
    
    // 注册collectionView
    [self.collectionView registerClass:[RightCollectionCell class] forCellWithReuseIdentifier:@"collCell"];
    // 注册头部区域
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}
#pragma mark - 获取数据
- (void)getData
{
//    http://mtest.ivpin.com//WPT-OpenAPI?control=LCatShop&action=getLcatCategory&shopuser=dl_lwgang
   
// ==================================商品种类数据===============================================
    NSString *path = [[NSBundle mainBundle] pathForResource:@"userList" ofType:@"plist"];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    
    NSString *url = [NSString stringWithFormat:@"http://mtest.ivpin.com//WPT-OpenAPI?control=LCatShop&action=getLcatCategory&shopuser=%@",[data objectForKey:@"name"]];
    
    [AFNetworkHandler GETWithAFNByURL:url completion:^(id result) {
        
        NSDictionary *tempDic = [NSDictionary dictionary];
        tempDic = result;
        self.leftdataArr = [NSMutableArray array];
        self.leftdataArr = [tempDic objectForKey:@"userCategory"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableVew reloadData];
        
        [self getRightData];
        
    }];

}
#warning 默认第一个商品类型的详细信息
- (void)getRightData
{
    
    NSString *pathList = [[NSBundle mainBundle] pathForResource:@"userList" ofType:@"plist"];
    NSMutableDictionary *dataList = [[NSMutableDictionary alloc] initWithContentsOfFile:pathList];
    if (self.leftdataArr.count < 1) {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"超市为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aler show];
        
    }else{
    NSString *righturl = [NSString stringWithFormat:@"http://mtest.ivpin.com//WPT-OpenAPI?control=LCatShop&action=getLcatProductListByCategoryID&shopuser=%@&categoryid=%@&pageindex=1&pagesize=20",[dataList objectForKey:@"name"],[self.leftdataArr[0] objectForKey:@"categoryID"]];

    //    NSLog(@"~~~~~~~~%@",url);
    [AFNetworkHandler GETWithAFNByURL:righturl completion:^(id result) {
        
        NSDictionary *tempDic = [NSDictionary dictionary];
        tempDic = result;
        self.rightdataArr = [NSMutableArray array];
        self.rightdataArr = [tempDic objectForKey:@"userProductList"];
        
        self.numOfcell = 0; // 保存点击第几个cell
        self.numArr = [NSMutableArray array]; // cell 的个数
        self.productCount = [NSMutableArray array]; // 判断商品是否为空
        for (int i = 0; i < self.rightdataArr.count; i++) { // 2是cell的个数
            [self.numArr addObject:@"0"];
            NSString *store = [NSString stringWithFormat:@"%@",[self.rightdataArr[i] objectForKey:@"store"]];
            [self.productCount addObject:store];//是否有库存
            
#warning 创建collectionView
            if (self.rightdataArr.count > 0) {
                [self.collectionView reloadData];   // 创建collection
            }
            
        }
        
        [self.collectionView reloadData];
        
        
    }];

    }
}
//=====================================TableView============================================
#pragma mark - tableView个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftdataArr.count;
}
#pragma mark - tableViewCell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableCell *leftCell = [tableView dequeueReusableCellWithIdentifier:@"tabCell" forIndexPath:indexPath];
    leftCell.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];
    
    // 选中背景颜色
    leftCell.selectedBackgroundView = [[UIView alloc] initWithFrame:leftCell.frame];
    leftCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    leftCell.leftView.tag = indexPath.row;
    leftCell.leftView.hidden = YES;
    if (indexPath.item == 0) {
        leftCell.leftView.backgroundColor = [UIColor orangeColor];
    }
    // 选中后的字体颜色
    leftCell.titleLable.highlightedTextColor = [UIColor orangeColor];
    leftCell.titleLable.text = [NSString stringWithFormat:@"%@",[self.leftdataArr[indexPath.item] objectForKey:@"categoryName"]];

    return leftCell;
}

#pragma mark - tableView点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    LeftTableCell *left = [[LeftTableCell alloc] init];
    UIView *v = (UIView *)[self.view viewWithTag:indexPath.row];
    v.hidden = NO;
    if (self.tempHidden != 0) {
        UIView *v = (UIView *)[self.view viewWithTag:self.tempHidden];
        v.hidden = YES;
    }else{
        UIView *v = (UIView *)[self.view viewWithTag:0];
        v.hidden = NO;
    }
        self.tempHidden = indexPath.row;
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"userList" ofType:@"plist"];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    //    NSLog(@"~~~~~~~~~~~~~~%@",[data objectForKey:@"name"]);
    
    NSString *url = [NSString stringWithFormat:@"http://mtest.ivpin.com//WPT-OpenAPI?control=LCatShop&action=getLcatProductListByCategoryID&shopuser=%@&categoryid=%@&pageindex=1&pagesize=20",[data objectForKey:@"name"],[self.leftdataArr[indexPath.item] objectForKey:@"categoryID"]];
    
//    NSLog(@"~~~~~~~~%@",url);
    [AFNetworkHandler GETWithAFNByURL:url completion:^(id result) {
        
        NSDictionary *tempDic = [NSDictionary dictionary];
        tempDic = result;
          self.rightdataArr = [NSMutableArray array];
        self.rightdataArr = [tempDic objectForKey:@"userProductList"];
        
        self.numOfcell = indexPath.item; // 保存点击第几个cell
        self.numArr = [NSMutableArray array]; // cell 的个数
        self.productCount = [NSMutableArray array]; // 判断商品是否为空
        for (int i = 0; i < self.rightdataArr.count; i++) { // 2是cell的个数
            [self.numArr addObject:@"0"];
            NSString *store = [NSString stringWithFormat:@"%@",[self.rightdataArr[i] objectForKey:@"store"]];
        [self.productCount addObject:store];//是否有库存
            
#warning 点击商品类别刷新collectionView
            if (self.rightdataArr.count > 0) {
                [self.collectionView reloadData];   // 创建collection
            }
            
        }
        
        [self.collectionView reloadData];
        
        
    }];
    
}

#warning 获取collecView数据
- (void)getCollectionData
{
    
}


////===================================Collection===============================================
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    // 通过判断kind参数类型 确定是头部区域还是尾部区域
    if (kind == UICollectionElementKindSectionHeader) {
        // 从头部区域重用池获取头部对象
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor clearColor];
        for (UILabel *la in header.subviews) {
            [la removeFromSuperview];
        }
        self.headLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH - 120, 30)];
        self.headLable.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];
        if (self.leftdataArr.count > 0) {
            self.headLable.text = [NSString stringWithFormat:@" %@",[self.leftdataArr[self.numOfcell] objectForKey:@"categoryName"]];
        }
        
        [header addSubview:self.headLable];
        
        return header;
    }
    return nil;
}



#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.rightdataArr.count;
}

#pragma mark - collectionView
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RightCollectionCell *collCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collCell" forIndexPath:indexPath];
    collCell.backgroundColor = [UIColor whiteColor];
    // 图片
    [collCell.imgView setImageWithURL:[NSURL URLWithString:[self.rightdataArr[indexPath.item]objectForKey:@"img"]] placeholderImage:[UIImage imageNamed:@"bgimg"]];
    // 标题
    collCell.titleLable.text = [self.rightdataArr[indexPath.item]objectForKey:@"name"];
    // 标签
    collCell.tagLable.text =[self.rightdataArr[indexPath.item]objectForKey:@"roperty"];
    // 现价
    collCell.nowMoney.text = [NSString stringWithFormat:@"￥%@",[self.rightdataArr[indexPath.item]objectForKey:@"sale"]];
    // 原价
    collCell.beforeMoney.text = [NSString stringWithFormat:@"￥%@",[self.rightdataArr[indexPath.item]objectForKey:@"market"]];
    
    // 减号按钮
    [collCell.subtraction addTarget:self action:@selector(subAction:) forControlEvents:UIControlEventTouchUpInside];
    // 加法按钮
    [collCell.addition addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 判断数组里的值是否为0 如果为0 隐藏减号button 否则显示
    if ([self.numArr[indexPath.item] isEqualToString:@"0"] && [self.productCount[indexPath.item] isEqualToString:@"0"] == 0) {
//        NSLog(@"~~~%@",self.numArr[indexPath.item]);
        
        collCell.subtraction.hidden = YES;
        collCell.nullProduct.hidden = YES;
        collCell.addition.hidden = NO;
        // 判断商品数量是否为空
    }else if([self.productCount[indexPath.item] isEqualToString:@"0"]){
        collCell.addition.hidden = YES;
         collCell.subtraction.hidden = YES;
        
        collCell.nullProduct.hidden = NO;
        
    }else{
        collCell.subtraction.hidden = NO;
        collCell.nullProduct.hidden = YES;
    }
    
    // 判断数组里的值是否为0 如果为0 lable隐藏 否则显示
    if ([self.numArr[indexPath.item] isEqualToString:@"0"]) {
        collCell.count.hidden = YES;
    }else{
        collCell.count.hidden = NO;
        collCell.count.text = self.numArr[indexPath.item];
    }

    
    
    return collCell;
}

#pragma mark - collectionView 的点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.item);
    
    ShopWebController *shopWeb = [[ShopWebController alloc] init];
    shopWeb.webUrl = [self.rightdataArr[indexPath.item] objectForKey:@"url"];
    
    [self.navigationController pushViewController:shopWeb animated:YES];
}


#pragma mark -  减号按钮方法
- (void)subAction:(UIButton *)button
{
    NSInteger temp = [self.numArr[button.tag] integerValue];
    temp--;
    
    [self.numArr replaceObjectAtIndex:button.tag withObject:[NSString stringWithFormat:@"%ld",temp]];
    NSLog(@"-------%@",self.numArr[button.tag]);
    NSLog(@"减号%ld",button.tag);
    
    NSString *strNum = @"0";
    NSInteger num = 0;
    for (int i = 0; i < self.numArr.count; i++) {
        NSString *temp = self.numArr[i];
        num += [temp integerValue];
    }
    strNum = [NSString stringWithFormat:@"%ld",num];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"collectNum" object:[UIColor redColor] userInfo:@{@"num":strNum,@"type":@"type"}];
    
    
    [self.collectionView reloadData];
    
}

#pragma mark - 加号按钮方法
- (void)addAction:(UIButton *)button
{
    
    NSInteger temp = [self.numArr[button.tag] integerValue];
    temp++;
    
    [self.numArr replaceObjectAtIndex:button.tag withObject:[NSString stringWithFormat:@"%ld",temp]];
    NSLog(@"-------%@",self.numArr[button.tag]);
    [self.collectionView reloadData];
    NSLog(@"加号%ld",button.tag);
#pragma mark - 判断商品库存
    // 商品数量
    NSString *store = [NSString stringWithFormat:@"%@",[self.rightdataArr[button.tag] objectForKey:@"store"]];
    NSInteger storeter = [store integerValue];
    // 收藏个数
    NSInteger count =  [self.numArr[button.tag] integerValue];
    if (storeter < count + 1) {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"商品库存不足" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
    }else{
    
    NSString *strNum = @"0";
    NSInteger num = 0;
    for (int i = 0; i < self.numArr.count; i++) {
        
        NSString *temp = self.numArr[i];
        num += [temp integerValue];

    }
    strNum = [NSString stringWithFormat:@"%ld",num];
    
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"collectNum" object:[UIColor redColor] userInfo:@{@"num":strNum,@"type":@"type"}];
    
    }
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
