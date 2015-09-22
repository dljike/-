//
//  RightCollectionCell.m
//  懒猫
//
//  Created by jike on 15/9/17.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "RightCollectionCell.h"

#import "Base.h"

@implementation RightCollectionCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[UIImageView alloc] init];
        [self addSubview:self.imgView];
        
        self.titleLable = [[UILabel alloc] init];
        [self addSubview:self.titleLable];
        
        self.tagLable = [[UILabel alloc] init];
        [self addSubview:self.tagLable];
        
        self.nowMoney = [[UILabel alloc] init];
        [self addSubview:self.nowMoney];
        
        self.beforeMoney = [[UILabel alloc] init];
        [self addSubview:self.beforeMoney];
        
        // - lable +
        self.subtraction = [[UIButton alloc] init];
        [self addSubview:self.subtraction];
        
        self.count = [[UILabel alloc] init];
        [self addSubview:self.count];
        
        self.addition = [[UIButton alloc] init];
        [self addSubview:self.addition];
        
        // 线
        self.lineView = [[UIView alloc] init];
        [self addSubview:self.lineView];
        
        // 没有商品
        self.nullProduct = [[UILabel alloc] init];
        [self addSubview:self.nullProduct];
        
        // cellView;
        self.cellView = [[UIView alloc] init];
        [self addSubview:self.cellView];
        
    }
    return self;
}


- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    // 图片
    self.imgView.frame = CGRectMake(0, 0, 80, 80);
    self.imgView.backgroundColor = [UIColor greenColor];
    
    // 标题
    self.titleLable.frame = CGRectMake(85, 10, layoutAttributes.size.width - 85, 20);
    self.titleLable.font = [UIFont fontWithName:nil size:15];
//        self.titleLable.text = @"都会新峰懒猫社";
    self.titleLable.backgroundColor = [UIColor whiteColor];
    
   // 标签
    self.tagLable.frame = CGRectMake(85, 30, 85, 20);
    self.tagLable.font = [UIFont fontWithName:nil size:14];
    self.tagLable.backgroundColor = [UIColor whiteColor];
    self.tagLable.textColor = [UIColor grayColor];
//    self.tagLable.text = @"400g 2粒装";
    
    // 现价
    self.nowMoney.frame = CGRectMake(80, 50, 60, 20);
    self.nowMoney.backgroundColor = [UIColor whiteColor];
//    self.nowMoney.text = @"¥40.8";
    self.nowMoney.textColor = [UIColor redColor];
//    self.nowMoney.font = [UIFont fontWithName:nil size:];
    
    // 原价
    self.beforeMoney.frame = CGRectMake(132, 50, 40, 20);
//    self.beforeMoney.text = @"¥2000";
    self.beforeMoney.font = [UIFont fontWithName:nil size:12];
    self.beforeMoney.textColor = [UIColor grayColor];
    
    // x线
    self.lineView.frame = CGRectMake(135, 60, 25, 1);
    self.lineView.backgroundColor = [UIColor grayColor];
    
    
    
    // 减号button
    self.subtraction.frame = CGRectMake(165, 35, 25, 25);
    //    [self.subtraction setTitle:@"-" forState:UIControlStateNormal];
    [self.subtraction setImage:[UIImage imageNamed:@"subtraction"] forState:UIControlStateNormal];
    [self.subtraction setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.subtraction.layer.borderWidth = 1;
    self.subtraction.layer.borderColor = [UIColor grayColor].CGColor;
    self.subtraction.backgroundColor = [UIColor whiteColor];
    self.subtraction.layer.cornerRadius = 25 / 2;
    self.subtraction.clipsToBounds = YES;
    self.subtraction.tag = layoutAttributes.indexPath.item;
    //    self.subtraction.tag = 1000;
    
    // 加号button
    self.addition.frame = CGRectMake(215, 35, 25, 25);
    //    [self.addition setTitle:@"+" forState:UIControlStateNormal];
    [self.addition setImage:[UIImage imageNamed:@"addition"] forState:UIControlStateNormal];
    [self.addition setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.addition.layer.borderWidth = 1;
    self.addition.layer.borderColor = [UIColor grayColor].CGColor;
    self.addition.backgroundColor = [UIColor whiteColor];
    self.addition.layer.cornerRadius = 25 / 2;
    self.addition.clipsToBounds = YES;
    self.addition.tag = layoutAttributes.indexPath.item;
    
    // 数量
    self.count.frame = CGRectMake(190, 40, 25, 20);
        self.count.backgroundColor = [UIColor whiteColor];
    self.count.textAlignment = NSTextAlignmentCenter;
    
    self.count.tag = layoutAttributes.indexPath.item;

    
    // 没有商品图片
    self.nullProduct.frame = CGRectMake(170, 40, 75, 30);
//    self.nullProduct.backgroundColor = [UIColor blackColor];
    self.nullProduct.text = @"补货中";
    self.nullProduct.textColor = [UIColor redColor];
    self.nullProduct.textAlignment = NSTextAlignmentRight;
    
    
    //cellView
    self.cellView.frame = CGRectMake(10, 80, layoutAttributes.size.width - 10, 1);
    self.cellView.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:243 / 255.0 blue:247 / 255.0 alpha:1];
     
    
    
}


















@end
