//
//  MyMessage.h
//  懒猫
//
//  Created by jike on 15/9/20.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMessage : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *longitude;// 经度
@property (nonatomic, retain) NSString *latitude; // 纬度
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, retain) NSString *titleName;

@end
