//
//  RecommendCell.m
//  懒猫
//
//  Created by jike on 15/9/12.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "RecommendCell.h"

@implementation RecommendCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgView = [[UIImageView alloc] init];
        [self addSubview:self.imgView];
        
        self.titleLable = [[UILabel alloc] init];
        [self addSubview:self.titleLable];
        
        self.weightLable = [[UILabel alloc] init];
        [self addSubview:self.weightLable];
        
        self.nowMoneyLable = [[UILabel alloc] init];
        [self addSubview:self.nowMoneyLable];
        
        self.beforeMoneyLable = [[UILabel alloc] init];
        [self addSubview:self.beforeMoneyLable];
        
        self.lineView = [[UIView alloc] init];
        [self addSubview:self.lineView];
        
        
        self.subtraction = [[UIButton alloc] init];
        [self addSubview:self.subtraction];
        
        self.count = [[UILabel alloc] init];
        [self addSubview:self.count];
        
        self.addition = [[UIButton alloc] init];
        [self addSubview:self.addition];
        
    }
    return  self;
}



-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.imgView.frame = CGRectMake(0, 0, layoutAttributes.size.width, layoutAttributes.size.height - 80);
    
    self.titleLable.frame = CGRectMake(5, layoutAttributes.size.height - 75, layoutAttributes.size.width, 20);
//    self.titleLable.font = [UIFont fontWithName:nil size:15];
//    self.titleLable.text = @"南非进口西柚";
    
    
    self.weightLable.frame = CGRectMake(5, layoutAttributes.size.height - 50, layoutAttributes.size.width / 2, 20);
    self.weightLable.font = [UIFont fontWithName:nil size:14];
    self.weightLable.textColor = [UIColor grayColor];
//    self.weightLable.text = @"400g 2粒装";
    
    // 现价Lable
    self.nowMoneyLable.frame = CGRectMake(5, layoutAttributes.size.height - 25, 60, 20);
//    self.nowMoneyLable.text = @"¥128.5";
    self.nowMoneyLable.textColor = [UIColor redColor];
    // 原价
    self.beforeMoneyLable.frame = CGRectMake(55, layoutAttributes.size.height - 25, 40, 20);
//    self.beforeMoneyLable.text = @"128.5";
    self.beforeMoneyLable.textColor = [UIColor grayColor];
    self.beforeMoneyLable.font = [UIFont fontWithName:nil size:13];
    // 原价删除线
    self.lineView.frame = CGRectMake(53, layoutAttributes.size.height - 15, 30, 1);
    self.lineView.backgroundColor = [UIColor grayColor];
    
    
    // 减号button
    self.subtraction.frame = CGRectMake(layoutAttributes.size.width - 80, layoutAttributes.size.height - 40, 25, 25);
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
    self.addition.frame = CGRectMake(layoutAttributes.size.width - 35, layoutAttributes.size.height - 40, 25, 25);
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
    self.count.frame = CGRectMake(layoutAttributes.size.width / 2 + 30, layoutAttributes.size.height - 35, 25, 20);
//    self.count.backgroundColor = [UIColor blackColor];
    self.count.textAlignment = NSTextAlignmentCenter;
    
    self.count.tag = layoutAttributes.indexPath.item;
}



@end
