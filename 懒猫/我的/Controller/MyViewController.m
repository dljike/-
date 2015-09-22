//
//  MyViewController.m
//  懒猫
//
//  Created by jike on 15/9/11.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "MyViewController.h"
#import "LoginTableViewCell.h"
#import "LoginViewController.h"
#import "MyTableViewCell.h"
#import "Base.h"
#import "PersonMessageController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate,PersonMessageDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSString *userName;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.userName = @"f";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO; // 导航不透明
    
    self.navigationItem.title = @"我的";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 100) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    // 隐藏多余的tableView
    [self setExtraCellLineHidden:self.tableView];
    
    [self.tableView registerClass:[LoginTableViewCell class] forCellReuseIdentifier:@"loginCell"];
    
}

// section 之间的间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 0;
    }
    return 10;
}

// section个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

// cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) { // 头像
        return 1;
    }else if (section == 1){ // 我的关注
        return 1;
    }else if (section == 2){ // 购物单
        return 2;
    }else if (section == 3){ // 我的钱包
        return 1;
    }else if (section == 4){ // 我分享的会员
        return 5;
    }
    return 0;
}


// cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return 80;
    }else{
        return 50;
    }
}
// cell显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    // 箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    // 登录
    if (indexPath.section == 0) {
        // 删除重复创建

        LoginTableViewCell *logincell = (LoginTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"logincell"];
        if (!logincell) {
            logincell = [[LoginTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"logincell"];
        }
        logincell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        logincell.headerImg.image = [UIImage imageNamed:@"headimg"];
        if ([self.userName isEqualToString:@"f"]) {
            logincell.loginLable.text = @"点击登陆/注册";
        }else{
             logincell.loginLable.text = self.userName;
        }
        
        return logincell;
        
        // 我的关注
    }else if (indexPath.section == 1){
        cell.accessoryType = UITableViewCellAccessoryNone;
        for (UIImageView *iv in cell.subviews) {
            [iv removeFromSuperview];
        }
        // 我的关注
        UIImageView *myCollect = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 80)];
        myCollect.image = [UIImage imageNamed:@"myattention"];
        [cell addSubview:myCollect];
        myCollect.userInteractionEnabled = YES;
        UITapGestureRecognizer *mycollectTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myCollectAction)];
        [myCollect addGestureRecognizer:mycollectTap];
        
        // 我的收藏
        UIImageView *myAttention = [[UIImageView alloc] initWithFrame:CGRectMake(125, 0, 125, 80)];
        myAttention.image = [UIImage imageNamed:@"mycollect"];
        [cell addSubview:myAttention];
        myAttention.userInteractionEnabled = YES;
        UITapGestureRecognizer *myAttentionTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myattentionAction)];
        [myAttention addGestureRecognizer:myAttentionTap];
        
        // 足迹
        UIImageView *footprint = [[UIImageView alloc] initWithFrame:CGRectMake(250, 0, 125, 80)];
        footprint.image = [UIImage imageNamed:@"footprint"];
        [cell addSubview:footprint];
        footprint.userInteractionEnabled = YES;
        UITapGestureRecognizer *footprintTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(footprintAction)];
        [footprint addGestureRecognizer:footprintTap];
        
        // 购物订单
    }else if (indexPath.section == 2){
        MyTableViewCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
        if (!mycell) {
            mycell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
        }
        mycell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // 箭头
        
        if (indexPath.item == 0) {
            mycell.headImg.image = [UIImage imageNamed:@"gwdd"];
            mycell.titleLable.text = @"购物订单";
        }else if(indexPath.item){
            mycell.headImg.image = [UIImage imageNamed:@"qtdd"];
            mycell.titleLable.text = @"其他订单";
        }
        
        return mycell;
        
       // 我的钱包
    }else if (indexPath.section == 3){
        for (UILabel *lab in cell.subviews) {
            [lab removeFromSuperview];
        }
        for (UIImageView *iv in cell.subviews) {
            [iv removeFromSuperview];
        }
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        img.backgroundColor = [UIColor blackColor];
        img.image = [UIImage imageNamed:@"wdqb"];
        [cell addSubview:img];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 80, 20)];
        lab.text = @"我的钱包";
        [cell addSubview:lab];
        
        UILabel *jf = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 180, 15, 150, 20)];
        jf.text = @"积分/现金";
        jf.textAlignment = NSTextAlignmentRight;
        jf.font = [UIFont fontWithName:nil size:13];
        jf.textColor = [UIColor grayColor];
        [cell addSubview:jf];
        
       // 我分享的会员
    }else if (indexPath.section == 4){
        MyTableViewCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
        if (!mycell) {
            mycell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
        }
        mycell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // 箭头

        if (indexPath.item == 0) {
            mycell.headImg.image = [UIImage imageNamed:@"wdfx"];
            mycell.titleLable.text = @"我分享的会员";
        }else if (indexPath.item == 1) {
            mycell.headImg.image = [UIImage imageNamed:@"cyxx"];
            mycell.titleLable.text = @"常用信息";
            mycell.litleLable.text = @"银行卡/常用地址";
            
        }else if (indexPath.item == 2){
            mycell.headImg.image = [UIImage imageNamed:@"xtgg"];
            mycell.titleLable.text = @"系统公告";
            mycell.litleLable.text = @"通知消息/主题消息";
        }else if (indexPath.item == 3){
            mycell.headImg.image = [UIImage imageNamed:@"yqhy"];
            mycell.titleLable.text = @"邀请好友";
            mycell.litleLable.text = @"邀请即送大红包";
        }else if (indexPath.item == 4){
            mycell.headImg.image = [UIImage imageNamed:@"shezhi"];
            mycell.titleLable.text = @"设置";
        }
        return mycell;
    }
    
    return cell;

}

#pragma mark - tableView的点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",indexPath.item);
    if (indexPath.section == 0) {
        if ([self.userName isEqualToString:@"f"]) {
            LoginViewController *login = [[LoginViewController alloc] init];
            login.delegate = self;
            [self presentViewController:login animated:YES completion:^{
                
            }];
        }else{
            // 跳转到详情页面
            PersonMessageController *pMessage = [[PersonMessageController alloc] init];
            [self presentViewController:pMessage animated:YES completion:^{
                
                
            }];
        }
      
        
    }
    
}
#pragma mark - 协议方法
- (void)personMessage:(NSDictionary *)message
{
    NSLog(@"%@",message);
    self.userName = [message objectForKey:@"mobile"];
    
    
    
    
    [self.tableView reloadData];
}

#pragma mark - 我的关注
- (void)myCollectAction
{
    NSLog(@"我的关注");
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"我的关注" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alt show];
}

#pragma  mark - 我的收藏
- (void)myattentionAction
{
    NSLog(@"我的收藏");
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"我的收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alt show];
}
#pragma mark - 我的足迹
- (void)footprintAction
{
    NSLog(@"我的足迹");
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"我的足迹" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alt show];
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
