//
//  LoginViewController.h
//  懒猫
//
//  Created by jike on 15/9/15.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PersonMessageDelegate <NSObject>

- (void)personMessage:(NSDictionary *)message;

@end

@interface LoginViewController : UIViewController


@property (nonatomic, retain) NSString *mainURL;

@property (nonatomic, assign) id<PersonMessageDelegate>delegate;



@end
