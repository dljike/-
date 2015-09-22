//
//  DataBase.m
//  懒猫
//
//  Created by jike on 15/9/20.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "DataBase.h"


@implementation DataBase

+(DataBase *)shareInstance
{
    // GCD多线程
    static DataBase *dbManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbManager = [[DataBase alloc] init];
    });
    return dbManager;
}

#warning 打开数据库
-(void)openDB
{
    // 获取documents路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//    NSLog(@"----------%@",path);
    
    // 拼接数据库路径
    NSString *dbPath = [path stringByAppendingPathComponent:@"person.db"];
    
    // 创建数据库
    // 数据库打开函数 会检测路径下 是否已经存在数据库(看dbPointer指针 是否指向了数据库) 如果不存在 则创建一个新的数据库 如果存在 直接打开原有的数据库
    // 参数1: 本地数据库路径(UTF-8转码)
    // 参数2: 数据库指针
    int result = sqlite3_open([dbPath UTF8String], &dbPoint);
    [self judgeResult:result type:@"打开数据库"];
    
}

#warning 关闭数据库

-(void)closeDB
{
    sqlite3_close(dbPoint);
}

#warning 创建表
-(void)createTable
{
    NSString *createSQL = @"create table if not exists person (name text, longitude text,latitude text,titleName text, num integer primary key autoincrement)";
    
    int result = sqlite3_exec(dbPoint, createSQL.UTF8String, NULL, NULL, NULL);
    
    [self judgeResult:result type:@"创建表"];
}

#warning 插入
-(void)insertInfo:(MyMessage *)message
{
    NSString *insertSQL = [NSString stringWithFormat:@"insert into person (name, longitude, latitude,titleName) values ('%@','%@','%@','%@')",message.name,message.longitude,message.latitude,message.titleName];
    
    int result = sqlite3_exec(dbPoint, insertSQL.UTF8String, NULL, NULL, NULL);
    
    [self judgeResult:result type:@"插入"];
}

#warning 删除
-(void)deleteInfo:(NSString *)name
{
    NSString *deleteSQL = [NSString stringWithFormat:@"delete from person where name = '%@'",name];
    
    int result = sqlite3_exec(dbPoint, deleteSQL.UTF8String, NULL, NULL, NULL);
    
    [self judgeResult:result type:@"删除"];
    
}

#warning 修改
-(void)updataInfo:(MyMessage *)message
{
    // 1. 创建sql语句
    NSString *updateSQL = [NSString stringWithFormat:@"update person set name = '%@',longitude = '%@',latitude = '%@',titleName = '%@' where num = '%ld'",message.name,message.longitude,message.latitude,message.titleName,message.num];
    
    // 2. 执行
    int result = sqlite3_exec(dbPoint, updateSQL.UTF8String, NULL, NULL, NULL);
    // 3. 判断
    [self judgeResult:result type:@"修改"];
}

#warning 查询
-(NSMutableArray *)selectInfo
{
    // 1. sql语句
    NSString *selectSQL = @"select * from person";
    
    // 2. 创建数据库替身
    sqlite3_stmt *stmt = nil;
    
    // 3. 准备sql语句
    // prepare_v2函数 把数据库对象(dbPointer)/sql语句/数据库替身 关联一起
    int result = sqlite3_prepare_v2(dbPoint, selectSQL.UTF8String, -1, &stmt, nil);
    
    // 4. 创建用于返回数据的数组
    NSMutableArray *arr = [NSMutableArray array];
    
    // 5. 判断查询准备是否成功
    if (result == SQLITE_OK) {
        NSLog(@"查询准备成功");
        // 6. 开始遍历每一行信息
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // 当数据库替身指向的数据符合查询条件 在while中返回
            // 逐行获取每一列信息
            // 列数 从0开始
            const unsigned char *name = sqlite3_column_text(stmt, 0);
            const unsigned char *longitude = sqlite3_column_text(stmt, 1);
            const unsigned char *latitude = sqlite3_column_text(stmt, 2);
            const unsigned char *titleName = sqlite3_column_text(stmt, 3);
            int num = sqlite3_column_int(stmt, 4);
           
            
            // 把获取到的数据信息保存在model中
            MyMessage *temp = [[MyMessage alloc]init];
            temp.name = [NSString stringWithUTF8String:(const char *)name];
            temp.longitude = [NSString stringWithUTF8String:(const char *)longitude];
            temp.latitude = [NSString stringWithUTF8String:(const char *)latitude];
            temp.titleName = [NSString stringWithUTF8String:(const char *)titleName];
            temp.num = num;
            // 添加到数组中
            [arr addObject:temp];
            
        }
    }else{
        NSLog(@"查询准备失败,原因:%d",result);
    }
    
    return  arr;
}
#warning 删除表
-(void)dropTable
{
    // 1. sql语句
    NSString *dropSQL = @"drop table person";
    // 2. 执行
    int result = sqlite3_exec(dbPoint, dropSQL.UTF8String, NULL, NULL, NULL);
    // 3. 判断
    [self judgeResult:result type:@"删除表"];
}



// 判断方法
- (void)judgeResult:(int)r type:(NSString *)type
{
    if (r == SQLITE_OK) {
        NSLog(@"%@操作成功",type);
    }else{
        NSLog(@"%@操作失败,原因:%d",type,r);
    }
}





@end
