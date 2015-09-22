//
//  RegisterViewController.m
//  懒猫
//
//  Created by jike on 15/9/16.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "RegisterViewController.h"
#import "Base.h"
#import "AFNetworkHandler.h"
@interface RegisterViewController ()

@property (nonatomic, retain) UITextField *phoneNum; // 电话号码
@property (nonatomic, retain) UITextField *yzm; // 验证码
@property (nonatomic, retain) UITextField *pwd; // 密码
@property (nonatomic, retain) UITextField *conPwd; // 确认密码

@end

@implementation RegisterViewController

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
    loginLable.text = @"登陆";
    loginLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    loginLable.textAlignment = NSTextAlignmentCenter;
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
    self.phoneNum.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneNum.placeholder = @"请输入电话号码";
    [self.view addSubview:self.phoneNum];
    // 线view
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 128, SCREEN_WIDTH - 10, 1)];
    lineView.backgroundColor =  [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];
    [self.view addSubview:lineView];
    // 验证码lable
    UILabel *pwd = [[UILabel alloc] initWithFrame:CGRectMake(0, 129, 100, 55)];
    pwd.backgroundColor = [UIColor whiteColor];
    pwd.text = @"  验证码";
    pwd.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:pwd];
    
    // 验证码textField
    self.yzm = [[UITextField alloc] initWithFrame:CGRectMake(100, 129, SCREEN_WIDTH - 100, 55)];
    self.yzm.backgroundColor = [UIColor whiteColor];
    self.yzm.placeholder = @"请输入验证码";
    [self.view addSubview:self.yzm];
    
    // 获取验证码Lable
    UILabel *getYzm = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 140, 100, 30)];
    getYzm.layer.cornerRadius = 15;
    getYzm.layer.borderWidth = 1;
    getYzm.layer.borderColor = [UIColor orangeColor].CGColor;
    getYzm.text = @"  获取验证码";
    getYzm.textColor = [UIColor orangeColor];
    getYzm.textAlignment = NSTextAlignmentLeft;
    getYzm.userInteractionEnabled = YES;
    [self.view addSubview:getYzm];
    UITapGestureRecognizer *getYzmTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getYzmTapAction)];
    [getYzm addGestureRecognizer:getYzmTap];
   
    // 密码Lable
    UILabel *pwdLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 184, 100, 55)];
    pwdLable.text = @"  密码";
    pwdLable.textAlignment = NSTextAlignmentLeft;
    pwdLable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pwdLable];
    // 密码textField
    self.pwd = [[UITextField alloc] initWithFrame:CGRectMake(100, 184, SCREEN_WIDTH - 100, 55)];
    self.pwd.backgroundColor = [UIColor whiteColor];
    self.pwd.placeholder = @"请输入密码";
    self.pwd.secureTextEntry = YES;
    self.pwd.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.pwd];
    // 密码上边的线
    UIView *pwdline = [[UIView alloc] initWithFrame:CGRectMake(10, 184, SCREEN_WIDTH - 10, 1)];
    pwdline.backgroundColor =  [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];
    [self.view addSubview:pwdline];

    // 确认密码Lable
    UILabel *conPwdLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 239, 100, 55)];
    conPwdLable.text = @"  确认密码";
    conPwdLable.backgroundColor = [UIColor whiteColor];
    conPwdLable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:conPwdLable];
    
    // 确认密码textField
    self.conPwd = [[UITextField alloc] initWithFrame:CGRectMake(100, 239, SCREEN_WIDTH - 100, 55)];
    self.conPwd.backgroundColor = [UIColor whiteColor];
    self.conPwd.clearButtonMode = UITextFieldViewModeAlways;
    self.conPwd.secureTextEntry = YES;
    self.conPwd.placeholder = @"请确认密码";
    [self.view addSubview:self.conPwd];
    
    // 确认密码上边的线
    UIView *conpwdline = [[UIView alloc] initWithFrame:CGRectMake(10, 239, SCREEN_WIDTH - 10, 1)];
    conpwdline.backgroundColor =  [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];
    [self.view addSubview:conpwdline];
    
    // 注册button
    UIButton *registButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 309, SCREEN_WIDTH - 40, 40)];
    [registButton setBackgroundImage:[UIImage imageNamed:@"regist"] forState:UIControlStateNormal];
    registButton.adjustsImageWhenHighlighted = NO;
    [registButton addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];
    
}
#pragma mark - 获取验证码方法
- (void)getYzmTapAction
{
    NSString *url = [NSString stringWithFormat:@"%@control=MemberCommon&action=GetCode&username=%@&sign=",self.mainURL,self.phoneNum.text];
    [AFNetworkHandler GETWithAFNByURL:url completion:^(id result) {
        // 18512150193
//        NSLog(@"%@",result);
    }];
}

#pragma mark - 注册按钮方法
- (void)registAction
{
   // 判断电话号码是否正确
    NSString *phone = self.phoneNum.text;
    if ([phone length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"电话号码不能为空", nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
        NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
        NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
        NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
        
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        
    
        if (([regextestmobile evaluateWithObject:phone] == YES)
            || ([regextestcm evaluateWithObject:phone] == YES)
            || ([regextestct evaluateWithObject:phone] == YES)
            || ([regextestcu evaluateWithObject:phone] == YES))
        {
            // 判断两次密码是否正确
            if ([self.pwd.text isEqualToString:self.conPwd.text] == 0) {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            // 判断密码是否为空
            }else if([self.pwd.text isEqualToString:@""] || [self.conPwd.text isEqualToString:@""]){
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            // 开始注册
            }else{
    NSString *url = [NSString stringWithFormat:@"%@control=MemberCommon&action=Reg&username=%@&pwd=%@&pwd2=%@&code=%@&sign=",self.mainURL,self.phoneNum.text,self.pwd.text,self.conPwd.text,self.yzm.text];
                NSLog(@"==============%@",url);
                 // 18512150193
            [AFNetworkHandler GETWithAFNByURL:url completion:^(id result) {
                NSLog(@"-------%@",result);
                NSDictionary *dic = [NSDictionary dictionary];
                if ([[dic objectForKey:@"r"] isEqualToString:@"T"]) {
                    
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                        
                    }];

                }else{
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }];
                
            }
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    }
    
    
    
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
//    [self.phoneNum resignFirstResponder];
//    [self.pwd resignFirstResponder];
        [self.view endEditing:YES];
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
