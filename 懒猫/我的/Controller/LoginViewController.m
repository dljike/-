//
//  LoginViewController.m
//  懒猫
//
//  Created by jike on 15/9/15.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "LoginViewController.h"
#import "Base.h"
#import "RegisterViewController.h"
#import "AFNetworkHandler.h"

@interface LoginViewController ()

@property (nonatomic, retain) UITextField *phoneNum;
@property (nonatomic, retain) UITextField *pwd;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainURL = @"http://mtest.ivpin.com//WPT-OpenAPI?";
    self.view.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];
    // 导航栏view
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    // 登陆lable
    UILabel * loginLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 50, 10, 100, 54)];
    loginLable.text = @"  登陆";
    loginLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    loginLable.textAlignment = NSTextAlignmentLeft;
    [navView addSubview:loginLable];
    // 导航栏返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    backButton.backgroundColor = [UIColor blackColor];
    [backButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    backButton.adjustsImageWhenHighlighted = NO; // 去掉button选中阴影
    [navView addSubview:backButton];
    
    // 手机号lable
    UILabel *phoneNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 74, 100, 55)];
    phoneNum.backgroundColor = [UIColor whiteColor];
    phoneNum.text = @"  手机号码";
    phoneNum.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:phoneNum];

    // 手机号textField
    self.phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(100, 74, SCREEN_WIDTH - 100, 55)];
    self.phoneNum.backgroundColor = [UIColor whiteColor];
    self.phoneNum.placeholder = @"请输入电话号码";
    [self.view addSubview:self.phoneNum];
    
    // 密码lable
    UILabel *pwd = [[UILabel alloc] initWithFrame:CGRectMake(0, 129, 100, 55)];
    pwd.backgroundColor = [UIColor whiteColor];
    pwd.text = @"  密码";
    pwd.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:pwd];
    
    // 密码textField
    self.pwd = [[UITextField alloc] initWithFrame:CGRectMake(100, 129, SCREEN_WIDTH - 100, 55)];
    self.pwd.backgroundColor = [UIColor whiteColor];
    self.pwd.placeholder = @"请输入密码";
    self.pwd.secureTextEntry = YES;
    [self.view addSubview:self.pwd];
    // 线view
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 128, SCREEN_WIDTH - 10, 1)];
    lineView.backgroundColor =  [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];
    [self.view addSubview:lineView];
    // 登陆按钮
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 204, SCREEN_WIDTH - 40, 40)];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
     loginButton.adjustsImageWhenHighlighted = NO;
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    // 注册lable
    UILabel *registLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 254, 100, 20)];
    registLable.text = @"3秒快速注册";
    registLable.font = [UIFont fontWithName:nil size:12];
//    registLable.textColor = [UIColor grayColor];
    [self.view addSubview:registLable];
    registLable.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *registTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registTapAction)];
    [registLable addGestureRecognizer:registTap];
    
    
    // 找回密码lable
    UILabel *findpwdLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 254, 100, 20)];
    findpwdLable.text = @"忘记密码了";
    findpwdLable.textAlignment = NSTextAlignmentRight;
    findpwdLable.font = [UIFont fontWithName:nil size:12];
    //    registLable.textColor = [UIColor grayColor];
    [self.view addSubview:findpwdLable];
    findpwdLable.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *findpwdTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findpwdTapAction)];
    [findpwdLable addGestureRecognizer:findpwdTap];
    
}


#pragma mark - 登陆按钮方法
- (void)loginAction
{
    NSString *url = [NSString stringWithFormat:@"%@control=MemberCommon&action=Login&username=%@&pwd=%@&usertype=0&sign=",self.mainURL,self.phoneNum.text,self.pwd.text];
   [AFNetworkHandler GETWithAFNByURL:url completion:^(id result) {
       NSDictionary *dic = [NSDictionary dictionary];
       dic = result;
       if ([[dic objectForKey:@"r"] isEqualToString:@"F"]) {
           UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
           [alert show];
       }else{
           NSDictionary *temp = [NSDictionary dictionary];
           temp = [dic objectForKey:@"d"];
           [self.delegate personMessage:temp];
           
           NSUserDefaults *pMessage = [NSUserDefaults standardUserDefaults];
           if (!pMessage) {
               [pMessage setObject:temp forKey:@"pMessage"];
               [pMessage synchronize];
           }
           
           [self dismissViewControllerAnimated:YES completion:^{
               
           }];
           
       }
       NSLog(@"---------%@",url);
       NSLog(@"=========%@",result);
//       18512150193
   }];
}

#pragma mark - 注册按钮方法
- (void)registTapAction
{
    RegisterViewController *regist = [[RegisterViewController alloc] init];
    [self presentViewController:regist animated:YES completion:^{
        
        
    }];
}

#pragma mark - 找回密码按钮方法
- (void)findpwdTapAction
{
    NSLog(@"findpwd");
}

// 返回按钮方法
- (void)backAction
{
    [self.view resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

// 回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.phoneNum resignFirstResponder];
    [self.pwd resignFirstResponder];
//    [self.view endEditing:YES];
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
