//
//  AFNetworkHandler.m
//  音悦咖
//
//  Created by dllo on 15/7/13.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import "AFNetworkHandler.h"

@implementation AFNetworkHandler

/**
 *  参数1: 网络接口
 *  参数2: 返回数据的block
 */
+ (void)GETWithAFNByURL:(NSString *)urlStr completion:(void (^)(id))block
{
    // 网址转码 处理中文字符
    NSString *str = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 创建AFN网络请求管理类
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置响应解析对象
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置数据支持类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", nil]];
    // AFN 的GET请求
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 请求成功执行的地方
        // responObject返回数据为NSData
        if (responseObject) {
            // 如果返回数据不为空 则开始JSON解析
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            // 通过block回调
            block(result);
            
        } else {
            NSLog(@"返回数据为空, 请检查");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求失败
        NSLog(@"请求失败: %@", error);
    }];
    
    
}

@end
