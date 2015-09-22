//
//  ChoosePresidentViewController.m
//  懒猫
//
//  Created by jike on 15/9/11.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "ChoosePresidentViewController.h"

#import "AFNetworkHandler.h"
#import "Base.h"
#import "ChooseCollectionViewCell.h"
#import "IndexViewController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "HandChooseController.h"
#import "LazyCatWebView.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

#define APIKey      @"071620a092034bf897e378d95923ffcb"

#define kDefaultLocationZoomLevel       16.1
#define kDefaultControlMargin           22

@interface ChoosePresidentViewController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic, retain) NSMutableArray *dataArr; // 数据数组
@property (nonatomic, retain) UICollectionView *collection;
@property (nonatomic, retain) UIView *searchView; // 搜索view
@property (nonatomic, retain) UISearchBar *search; // 搜索bar
@property (nonatomic, retain) UIImageView *imgView; // 附近无信息图片

@property (nonatomic, retain) MAMapView *mapView;

@end

@implementation ChoosePresidentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainURL = @"http://mtest.ivpin.com//WPT-OpenAPI?";
    
    self.view.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:241 / 255.0 blue:247 / 255.0 alpha:1];
    self.navigationItem.title = @"选择周边社长";
    
    // 隐藏返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:nil target:self action:nil];
    // 手动选择
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.text = @"手动选择";
    titleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *lableTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handchoseAction)];
    [titleLabel addGestureRecognizer:lableTap];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    

    // 导航栏 搜索框
    [self  searchPresident];
    // 创建collection
    [self createCollection];
    // 获取数据
    [self getData];
    
    // 地图定位
    [self getMap];
    
}
// 初始化地图
- (void)getMap
{
    [MAMapServices sharedServices].apiKey = APIKey;
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, 0,0)];
    _mapView.delegate = self;
    // 罗盘位置
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, kDefaultControlMargin);
    // 比例尺位置
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, kDefaultControlMargin);
    
    [self.view addSubview:_mapView];
    
    if (self.mapView.showsUserLocation == NO)
        
    {
        self.mapView.showsUserLocation = YES;
    }
     
    _mapView.pausesLocationUpdatesAutomatically = NO;  // 后台定位
}

// 试图将要出现
-(void)viewWillAppear:(BOOL)animated
{
    if (_mapView.userTrackingMode != MAUserTrackingModeNone)
        // 不追中 MAUserTrackingModeNone
    {
        _mapView.userTrackingMode = MAUserTrackingModeNone;
        [_mapView setZoomLevel:kDefaultLocationZoomLevel animated:YES];
        
    }

//       _mapView.showsUserLocation = YES;
}

#pragma mark - 获取数据
- (void)getData
{
    self.dataArr = [NSMutableArray array];
    // －122.406417
    // 37.785834
    NSString *url = [NSString stringWithFormat:@"%@x=-122.406417&y=37.785834&sign=",self.mainURL];
//    NSLog(@"=================%@",url);
    [AFNetworkHandler GETWithAFNByURL:url completion:^(id result) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic = result;
//        self.dataArr = [dic objectForKey:@"shops"];
        
        if (self.dataArr.count > 0) {
            self.imgView.hidden = YES;
            self.collection.scrollEnabled = YES;
        }
        [self.collection reloadData];
    }];
    
    
    if (self.dataArr.count < 1) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        self.imgView.backgroundColor = [UIColor redColor];
        self.imgView.image = [UIImage imageNamed:@"nearnull"];
        self.imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapAction)];
        [self.imgView addGestureRecognizer:imgTap];
        [self.view addSubview:self.imgView];
        
        self.collection.scrollEnabled = NO;
    }
    
}
#pragma mark - 跳转手动搜索
- (void)imgTapAction
{
    HandChooseController *hand = [[HandChooseController alloc] init];
    [self.navigationController pushViewController:hand animated:YES];

}

#pragma  mark - 创建collection
- (void)createCollection
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH - 0, SCREEN_HEIGHT - 80) collectionViewLayout:layout];
    self.collection.dataSource = self;
    self.collection.delegate = self;
    self.collection.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:241 / 255.0 blue:247 / 255.0 alpha:1];
    [self.view addSubview:self.collection];
    
#pragma mark - 刷新
    [self.collection addHeaderWithTarget:self action:@selector(RefreshAction)];
    
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"titleCell"];
    
    [self.collection registerClass:[ChooseCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
#pragma mark - cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return self.dataArr.count;
    }
    return 100;
}




//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 30);
    }
    return CGSizeMake(SCREEN_WIDTH / 2 - 10, SCREEN_HEIGHT * 0.3);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(5, 0, 0, 0);
    }
    return UIEdgeInsetsMake(5, 5, 0, 5);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        UICollectionViewCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
        titleCell.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:241 / 255.0 blue:247 / 255.0 alpha:1];
        
        // 删除重复创建的Lable
//        for (UILabel *la in titleCell.subviews) {
//            [la removeFromSuperview];
//        }
//        
//        for (UILabel *la in titleCell.subviews) {
//            [la removeFromSuperview];
//        }
        
        UILabel *near = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        near.text = @"周边社长";
        near.textColor = [UIColor grayColor];
        [titleCell addSubview:near];
        
        UILabel *moreLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 5, 40, 20)];
        moreLable.text = @"更多";
        moreLable.font = [UIFont fontWithName:nil size:14];
        moreLable.textColor = [UIColor grayColor];
       
        moreLable.userInteractionEnabled = YES;
        moreLable.textAlignment = NSTextAlignmentRight;
        
        // 更多Lable 的点击方法
        UITapGestureRecognizer *moreTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreTapAction)];
        [moreLable addGestureRecognizer:moreTap];
        [titleCell addSubview:moreLable];
        
        return titleCell;
        
    }else if(indexPath.section == 1) {
    ChooseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
        // 背景图片
        NSString *imgUrl = [self.dataArr[indexPath.item] objectForKey:@"img"];
    [cell.imgView setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"bgimg"]];
        //标题
        cell.titleLable.text = [self.dataArr[indexPath.item] objectForKey:@"name"];
        //标签（免费配送）
        cell.freeLable.text = [self.dataArr[indexPath.item] objectForKey:@"tag"];
        // 营业时间
        NSString *tempTime = [NSString stringWithFormat:@"营业时间:%@",[self.dataArr[indexPath.item] objectForKey:@"opentime"]];
        cell.bendTime.text = tempTime;
        // 距离
        cell.distance.text = [self.dataArr[indexPath.item] objectForKey:@"distance"];
        
    return cell;
        
    }
    return nil;
}
// 更多Lable的点击方法
- (void)moreTapAction
{
    NSLog(@"更多");
}

#pragma mark - cell点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    NSLog(@"%ld",indexPath.section);
    // 去掉键盘
    [self.search resignFirstResponder];
    
    // 跳转webView
    if (indexPath.section == 1) {
        
        IndexViewController *index = [[IndexViewController alloc] init];
        
        [self.navigationController pushViewController:index animated:YES];
        
//        NSLog(@"%@",[self.dataArr[indexPath.item] objectForKey:@"cityid"]);
    }

}


// 导航栏，搜索框
- (void)searchPresident
{
    self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 30)];
    self.search.placeholder = @"请输入社长店铺名称";
    self.search.delegate = self;
    [self.view addSubview:self.search];
    
    UITapGestureRecognizer *deletBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
    [self.navigationController.navigationBar addGestureRecognizer:deletBoard];
    
    
}


#pragma mark - 搜索协议
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@",searchBar.text);
     [self.search resignFirstResponder];
    
}

#pragma mark - 实时搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText);
}

//tap view 回收键盘
- (void)tapView
{
    [self.search resignFirstResponder];
    
}

// 手动选择
- (void)handchoseAction
{
    HandChooseController *hand = [[HandChooseController alloc] init];
    [self.navigationController pushViewController:hand animated:YES];
    
//    [self presentViewController:hand animated:YES completion:^{
//        
//    }];
}


#pragma mark - 刷新方法
- (void)RefreshAction
{
    [self.collection reloadData];
    [self.collection headerEndRefreshing];
    
}


#pragma mark - 地图
// ========================地图=========================================================
//==============================定位============================================================




-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"纬度 : %f,经度: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
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
