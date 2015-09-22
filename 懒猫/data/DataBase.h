//
//  DataBase.h
//  懒猫
//
//  Created by jike on 15/9/20.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "MyMessage.h"


@interface DataBase : NSObject


{
    sqlite3 *dbPoint;
}

+(DataBase *)shareInstance;

// 打开数据库
-(void)openDB;

// 关闭数据库
-(void)closeDB;

// 创建表
-(void)createTable;

// 添加数据
-(void)insertInfo:(MyMessage *)message;

// 删除数据
-(void)deleteInfo:(NSString *)name;

// 修改数据
-(void)updataInfo:(MyMessage *)message;

// 查询数据
-(NSMutableArray *)selectInfo;

// 删除表
- (void)dropTable;


@end
