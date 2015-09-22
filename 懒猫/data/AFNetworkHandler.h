//
//  AFNetworkHandler.h
//  音悦咖
//
//  Created by dllo on 15/7/13.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface AFNetworkHandler : NSObject

+ (void)GETWithAFNByURL:(NSString *)urlStr completion:(void(^)(id result))block;

@end
