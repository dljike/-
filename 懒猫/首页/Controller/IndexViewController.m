//
//  IndexViewController.m
//  懒猫
//
//  Created by jike on 15/9/11.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "IndexViewController.h"

#import "ChoosePresidentViewController.h"
#import "Base.h"
#import "SDCycleScrollView.h"
#import "AFNetworkHandler.h"
#import "FourButtonCollectionViewCell.h"
#import "SupermarketViewController.h"
#import "ImageCell.h"
#import "RecommendCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "FourButtonWebViewController.h"
#import "ShopCarViewController.h"

@interface IndexViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

@property (nonatomic, retain) UICollectionView *collection;

@property (nonatomic, retain) NSString *mainURL;
@property (nonatomic, retain) NSArray *titleArr; // 轮播图数据
@property (nonatomic, retain) NSMutableArray *numArr; // 保存添加的产品数量
@property (nonatomic, retain) NSMutableArray *cellNumArr; // 社长热卖cell的个数
@property (nonatomic, retain) NSMutableDictionary *dataDic; // 获取熱result数据
@property (nonatomic, retain) NSMutableArray *shopadsArr; // 推荐产品
@property (nonatomic, retain) NSMutableArray *products; // 社长热卖
@property (nonatomic, retain) NSMutableDictionary *modelDic; // 四个按钮链接地址
@property (nonatomic, retain) UILabel *navLable; // 导航lable
@property (nonatomic, retain) NSDictionary *xyData; // 通知社区传过来的经纬度和名字
@property (nonatomic, retain) NSString * longitude; // 经度
@property (nonatomic, retain) NSString * latitude; // 纬度

@end

@implementation IndexViewController


#pragma mark - 通知中心初始化
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 通知的注册一般放在初始化中
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
    [center addObserver:self selector:@selector(changeColor:) name:@"color" object:nil];
    
    
}
#warning 3. 收到post通知后 执行注册好的方法
-(void)changeColor:(NSNotification *)noti
{
//        // 通知名
//        NSLog(@"%@",noti.name);
//        // 传递的参数
//        NSLog(@"%@",noti.object);
        // 传递的字典
//        NSLog(@"==========%@",[noti.userInfo objectForKey:@"cityID"]);
    self.xyData = [NSDictionary dictionary];
    
     self.navLable.text = [NSString stringWithFormat:@"%@ ▾",[noti.userInfo objectForKey:@"name"]]; //导航名字
    
    // x: 经度 y: 纬度
//    NSString *x = @"121.160695000000000";
//    NSString *y = @"31.298032000000000";
    
    self.longitude = [noti.userInfo objectForKey:@"x"]; // 经度
    self.latitude = [noti.userInfo objectForKey:@"y"]; // 纬度
    
#warning 获取传过来的社长商品推荐信息
//    NSString *user = @"dl_wzxiang";  //18616721356
    NSString *user = [noti.userInfo objectForKey:@"shopuser"];
    
    NSString *url = [NSString stringWithFormat:@"%@control=LCatCommon&action=Index&shopuser=%@&x=%@&y=%@&username=&sign=",self.mainURL,user,self.longitude,self.latitude];
//    NSLog(@"=============%@",url);
    [AFNetworkHandler GETWithAFNByURL:url completion:^(id result) {
        
        NSDictionary *tempDic = [NSDictionary dictionary];
        tempDic = result;
        self.products = [tempDic objectForKey:@"products"];
        
        self.numArr = [NSMutableArray array];
        for (int i = 0; i < self.products.count; i++) { // 2是cell的个数
            
            [self.numArr addObject:@"0"];
            
        }

        [self.collection reloadData];
    }];
    
    
}




//=======================================================

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.mainURL = @"http://mtest.ivpin.com//WPT-OpenAPI?";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO; // 导航不透明
    // 导航左边logo
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    leftButton.backgroundColor = [UIColor whiteColor];
    leftButton.adjustsImageWhenHighlighted = NO;
    [leftButton setImage:[UIImage imageNamed:@"logo"] forState:UIControlStateNormal];
    [self.view addSubview:leftButton];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 导航右边搜索按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    rightButton.backgroundColor = [UIColor whiteColor];
    rightButton.adjustsImageWhenHighlighted = NO;
    [rightButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.view addSubview:rightButton];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
    self.navLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    navLable.backgroundColor = [UIColor whiteColor];
    NSString *navTitle = [NSString stringWithFormat:@"%@ ▾", [self.xyData objectForKey:@"name"]];
    self.navLable.text = navTitle;
    self.navigationItem.titleView = self.navLable;
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    self.navLable.userInteractionEnabled = YES;
    [self.navLable addGestureRecognizer:tap];
    
    // 获取数据
    [self getData];
    
    // 创建collection
    [self createCollection];
    
    
    
}

#pragma mark - search按钮
- (void)searchAction
{
    NSLog(@"搜索");
}

#pragma mark - 获取数据
- (void)getData
{
    
//    self.cellNumArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
//    NSLog(@"-----arr---%@",self.cellNumArr);
    // 给数组赋值
    
// http://mtest.ivpin.com//WPT-OpenAPI?control=LCatCommon&action=Index&shopuser =18616721356&x=121.160695000000000&y=31&y=31.298032000000000&username=&sign=
    
    
    // x: 经度 y: 纬度
    NSString *x = @"121.160695000000000";
    NSString *y = @"31.298032000000000";
    NSString *user = @"dl_wzxiang";  //18616721356
    NSString *url = [NSString stringWithFormat:@"%@control=LCatCommon&action=Index&shopuser=%@&x=%@&y=%@&username=&sign=",self.mainURL,user,x,y];
    [AFNetworkHandler GETWithAFNByURL:url completion:^(id result) {
        
        self.dataDic = [NSMutableDictionary dictionary];
        self.dataDic = result;
        
        // 轮播图
        self.titleArr = [NSArray array];
        self.titleArr = [self.dataDic objectForKey:@"ads"];;
        // 推荐产品
        self.shopadsArr = [NSMutableArray array];
        self.shopadsArr = [self.dataDic objectForKey:@"shopads"];
        // 社长推荐产品
        self.products = [NSMutableArray array];
        self.products = [self.dataDic objectForKey:@"products"];
        // 按钮地址
        self.modelDic = [NSMutableDictionary dictionary];
        self.modelDic = [self.dataDic objectForKey:@"model"];
        
        self.numArr = [NSMutableArray array];
        for (int i = 0; i < self.products.count; i++) { // 2是cell的个数
            
            [self.numArr addObject:@"0"];
            
        }
        
        [self.collection reloadData];
    }];
}


#pragma mark - 创建collection
- (void)createCollection
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    
    self.collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collection.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:241 / 255.0 blue:247 / 255.0 alpha:1];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.view addSubview:self.collection];
    
#pragma mark - 刷新
    [self.collection addHeaderWithTarget:self action:@selector(refreshAction)];
    
#pragma mark - cell 注册
    // 4个button
    [self.collection registerClass:[FourButtonCollectionViewCell class] forCellWithReuseIdentifier:@"FourButton"];
    // 图片cell
    [self.collection registerClass:[ImageCell class] forCellWithReuseIdentifier:@"imgCell"];
    // 社长推荐cell
    [self.collection registerClass:[RecommendCell class] forCellWithReuseIdentifier:@"RecommendCell"];
    
    
    // 轮播图header
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    // 社长热卖header
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"shopheader"];

}

// 刷新方法
-(void)refreshAction
{
    [self.collection reloadData];
    [self.collection headerEndRefreshing];
    
}

#pragma mark - header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH , 160);
    }else if (section == 2){
        return CGSizeMake(SCREEN_WIDTH, 30);
    }
    
    return CGSizeMake(0, 0);
}
#pragma mark - 头部显示内容／轮播图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor grayColor];
        
        // 轮播图
        NSMutableArray *tempArr = [NSMutableArray array];
        NSArray *temp = self.titleArr;
        for (int i = 0;  i < temp.count; i++) {
            if (temp.count > 0) {
                [tempArr addObject:[temp[i] objectForKey:@"img"]];
            }
            
        }
        SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) imageURLStringsGroup:tempArr];
        cycleView.delegate = self;
        
        // 是否显示分页控制器
        cycleView.showPageControl = NO;
        cycleView.autoScrollTimeInterval = 3;
        [header addSubview:cycleView];
        
        
        return header;
    }
        // 社长热卖lable
    }else if (indexPath.section ==  2){
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *shopheader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"shopheader" forIndexPath:indexPath];
            shopheader.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:241 / 255.0 blue:247 / 255.0 alpha:1];
            
            // 删除重复创建的Lable
            for (UILabel *la in shopheader.subviews) {
                [la removeFromSuperview];
            }
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
            lable.text = @"社长热卖";
            [shopheader addSubview:lable];
            
            return shopheader;
            
        }
    }
    
    return nil;
}
#pragma mark - 轮播图点击方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    FourButtonWebViewController *saleWeb = [[FourButtonWebViewController alloc] init];
    saleWeb.webUrl = [self.titleArr[index] objectForKey:@"url"];

    [self.navigationController pushViewController:saleWeb animated:YES];
    
    
    NSLog(@"%ld",index);
    
}

#pragma mark - section 个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

#pragma mark - cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.shopadsArr.count;
    }else if (section == 2){
    return self.products.count; //加减cell个数
    }
    return 1;
}

#pragma mark - cell 大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 0.135);
    }else if (indexPath.section == 1){
        return CGSizeMake(SCREEN_WIDTH - 20, SCREEN_HEIGHT * 0.195);
    }else if (indexPath.section == 2){
        return CGSizeMake(SCREEN_WIDTH / 2 - 15, SCREEN_HEIGHT * 0.375);
    }else if (indexPath.section == 3){
        return CGSizeMake(SCREEN_WIDTH, 30); // 加载更多
    }
    return CGSizeMake(SCREEN_WIDTH - 20, SCREEN_HEIGHT * 0.15);
}

#pragma mark -  边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }
    if (section == 3) {
        return UIEdgeInsetsMake(0, 0, 70, 0);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - cell 显示内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

#pragma mark - section0 4个buuton
    if (indexPath.section == 0) {
        
        FourButtonCollectionViewCell *fourButton = [collectionView dequeueReusableCellWithReuseIdentifier:@"FourButton" forIndexPath:indexPath];
        fourButton.backgroundColor = [UIColor whiteColor];
        
        // 抢红包button
        [fourButton.redPacket addTarget:self action:@selector(redPacketAction) forControlEvents:UIControlEventTouchUpInside];
        // 积分兑换button
        [fourButton.score addTarget:self action:@selector(scoreAction) forControlEvents:UIControlEventTouchUpInside];
        // 促销
        [fourButton.sale addTarget:self action:@selector(saleAction) forControlEvents:UIControlEventTouchUpInside];
        // 懒猫超市
         [fourButton.supermarket addTarget:self action:@selector(supermarketAction) forControlEvents:UIControlEventTouchUpInside];
        
        return fourButton;
#pragma mark - section1推荐显示图片
    }else if (indexPath.section == 1){
        
        ImageCell *imgCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imgCell" forIndexPath:indexPath];
        imgCell.backgroundColor = [UIColor grayColor];
        
        NSString *str = [self.shopadsArr[indexPath.item] objectForKey:@"img"];
        
        [imgCell.img setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"bgimg"]];
        
        
        return imgCell;
#pragma mark - section2 社长热卖
    }else if (indexPath.section == 2){
        
        RecommendCell *recommend = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCell" forIndexPath:indexPath];
        recommend.backgroundColor = [UIColor whiteColor];
        // 图片
        [recommend.imgView setImageWithURL:[NSURL URLWithString:[self.products[indexPath.item] objectForKey:@"img"]] placeholderImage:[UIImage imageNamed:@"bgimg"]];
        recommend.backgroundColor = [UIColor whiteColor];
        // 商品名
        recommend.titleLable.text = [self.products[indexPath.item] objectForKey:@"name"];
        // 商品描述
        recommend.weightLable.text = [self.products[indexPath.item] objectForKey:@"roperty"];
        // 现价
        NSString *sale = [NSString stringWithFormat:@"¥%@",[self.products[indexPath.item] objectForKey:@"sale"]];
        recommend.nowMoneyLable.text = sale;
        // 原价
        NSString *market = [NSString stringWithFormat:@"¥%@",[self.products[indexPath.item] objectForKey:@"market"]];
        recommend.beforeMoneyLable.text = market;
        
        // 减号按钮
        [recommend.subtraction addTarget:self action:@selector(subtractionAction:) forControlEvents:UIControlEventTouchUpInside];
        // 加法按钮
        [recommend.addition addTarget:self action:@selector(additionAction:) forControlEvents:UIControlEventTouchUpInside];
  
            // 判断数组里的值是否为0 如果为0 隐藏减号button 否则显示
            if ([self.numArr[indexPath.item] isEqualToString:@"0"]) {
//                NSLog(@"~~~%@",self.numArr[indexPath.item]);
                
                recommend.subtraction.hidden = YES;

            }else{
                
                recommend.subtraction.hidden = NO;
            }
        
        // 判断数组里的值是否为0 如果为0 lable隐藏 否则显示
        if ([self.numArr[indexPath.item] isEqualToString:@"0"]) {
            recommend.count.hidden = YES;
        }else{
            recommend.count.hidden = NO;
            recommend.count.text = self.numArr[indexPath.item];
        }
        
        
        return recommend;
    }else if (indexPath.section == 3){
        ImageCell *refresh = [collectionView dequeueReusableCellWithReuseIdentifier:@"imgCell" forIndexPath:indexPath];
        refresh.img.image = [UIImage imageNamed:@"refresh"];
        
        return refresh;
    }
  
    
    return nil;
    
}

#pragma mark - 减号方法
- (void)subtractionAction:(UIButton *)button
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
    
    
    
    [self.collection reloadData];
  
}

#pragma mark - 加号方法
- (void)additionAction:(UIButton *)button
{
    
    NSInteger temp = [self.numArr[button.tag] integerValue];
    temp++;
    
    [self.numArr replaceObjectAtIndex:button.tag withObject:[NSString stringWithFormat:@"%ld",temp]];
    NSLog(@"-------%@",self.numArr[button.tag]);
    [self.collection reloadData];
    NSLog(@"加号%ld",button.tag);
    
    NSString *strNum = @"0";
    NSInteger num = 0;
    for (int i = 0; i < self.numArr.count; i++) {
        NSString *temp = self.numArr[i];
        num += [temp integerValue];
    }
    strNum = [NSString stringWithFormat:@"%ld",num];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"collectNum" object:[UIColor redColor] userInfo:@{@"num":strNum,@"type":@"type"}];
}




#pragma mark - 抢红包
- (void)redPacketAction
{
    FourButtonWebViewController *redWeb = [[FourButtonWebViewController alloc] init];
    redWeb.webUrl = [self.modelDic objectForKey:@"hongbao"];
    
    [self.navigationController pushViewController:redWeb animated:YES];
    
    NSLog(@"抢红包");
}
#pragma mark - 积分兑换
- (void)scoreAction
{
    FourButtonWebViewController *scoreWeb = [[FourButtonWebViewController alloc] init];
    scoreWeb.webUrl = [self.modelDic objectForKey:@"jifen"];
    
    [self.navigationController pushViewController:scoreWeb animated:YES];
    
    NSLog(@"积分兑换");
}
#pragma mark - 促销
- (void)saleAction
{
    
    FourButtonWebViewController *saleWeb = [[FourButtonWebViewController alloc] init];
    saleWeb.webUrl = [self.modelDic objectForKey:@"cuxiao"];
    
    [self.navigationController pushViewController:saleWeb animated:YES];

    NSLog(@"促销");
}
#pragma mark - 懒猫超市
- (void)supermarketAction
{
    SupermarketViewController *supermarket = [[SupermarketViewController alloc] init];
    [self.navigationController pushViewController:supermarket animated:YES];
    NSLog(@"懒猫超市");
}


#pragma mark - cell的点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",indexPath.item);
    
    
    if (indexPath.section == 1) {
        FourButtonWebViewController *saleWeb = [[FourButtonWebViewController alloc] init];
        saleWeb.webUrl = [self.shopadsArr[indexPath.item] objectForKey:@"url"];
        
        [self.navigationController pushViewController:saleWeb animated:YES];

    }
    
    if (indexPath.section == 2) {
        
        FourButtonWebViewController *saleWeb = [[FourButtonWebViewController alloc] init];
        saleWeb.webUrl = [self.products[indexPath.item] objectForKey:@"url"];
    
        [self.navigationController pushViewController:saleWeb animated:YES];

        
    }
    // 加载更多数据
    if (indexPath.section == 3) {
        for (int i = 0; i < 4; i++) {
            [self.cellNumArr addObject:@"cell"];
            [self.numArr addObject:@"0"];
        }
        [self.collection reloadData];
    }
    
}


// 跳转选择社长页面
- (void)tapAction
{
    ChoosePresidentViewController *choose = [[ChoosePresidentViewController alloc] init];
    
    [self.navigationController pushViewController:choose animated:YES];
//    [self presentViewController:choose animated:YES completion:^{
//        
//        
//    }];
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
