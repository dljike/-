//
//  FourButtonCollectionViewCell.m
//  懒猫
//
//  Created by jike on 15/9/12.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "FourButtonCollectionViewCell.h"

@implementation FourButtonCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.redPacket = [[UIButton alloc]init];
        [self addSubview:self.redPacket];
        self.redPacketLable = [[UILabel alloc] init];
        [self addSubview:self.redPacketLable];
        
        self.score = [[UIButton alloc] init];
        [self addSubview:self.score];
        self.scoreLable = [[UILabel alloc] init];
        [self addSubview:self.scoreLable];
        
        self.sale = [[UIButton alloc] init];
        [self addSubview:self.sale];
        self.saleLable = [[UILabel alloc] init];
        [self addSubview:self.saleLable];
        
        self.supermarket = [[UIButton alloc] init];
        [self addSubview:self.supermarket];
        self.supermarketLable = [[UILabel alloc] init];
        [self addSubview:self.supermarketLable];
        
    }
    return self;
}


-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.redPacket.frame = CGRectMake(20, 10, 50, 50);
    self.redPacket.layer.cornerRadius = 25;
    self.redPacket.clipsToBounds = YES;
    self.redPacket.backgroundColor = [UIColor whiteColor];
    [self.redPacket setImage:[UIImage imageNamed:@"hongbao"] forState:UIControlStateNormal];
    self.redPacketLable.frame = CGRectMake(10, 60, 70, 20);
    self.redPacketLable.textAlignment = NSTextAlignmentCenter;
    self.redPacketLable.text = @"抢红包";
    self.redPacketLable.font = [UIFont fontWithName:nil size:14];
    
    self.score.frame = CGRectMake(110, 10, 50, 50);
    self.score.layer.cornerRadius = 25;
    self.score.clipsToBounds = YES;
    self.score.backgroundColor = [UIColor whiteColor];
    [self.score setImage:[UIImage imageNamed:@"jifen"] forState:UIControlStateNormal];
    self.scoreLable.frame = CGRectMake(100, 60, 70, 20);
    self.scoreLable.textAlignment = NSTextAlignmentCenter;
    self.scoreLable.text = @"积分兑换";
    self.scoreLable.font = [UIFont fontWithName:nil size:14];
    
    self.sale.frame = CGRectMake(200, 10, 50, 50);
    self.sale.layer.cornerRadius = 25;
    self.sale.clipsToBounds = YES;
    self.sale.backgroundColor = [UIColor whiteColor];
    [self.sale setImage:[UIImage imageNamed:@"cuxiao"] forState:UIControlStateNormal];
    self.saleLable.frame = CGRectMake(190, 60, 70, 20);
    self.saleLable.textAlignment = NSTextAlignmentCenter;
    self.saleLable.text = @"促销";
    self.saleLable.font = [UIFont fontWithName:nil size:14];
    
    
    self.supermarket.frame = CGRectMake(290, 10, 50, 50);
    self.supermarket.layer.cornerRadius = 25;
    self.supermarket.clipsToBounds = YES;
    self.supermarket.backgroundColor = [UIColor whiteColor];
    [self.supermarket setImage:[UIImage imageNamed:@"lmmark"] forState:UIControlStateNormal];
    self.supermarketLable.frame = CGRectMake(280, 60, 70, 20);
    self.supermarketLable.textAlignment = NSTextAlignmentCenter;
    self.supermarketLable.text = @"懒猫超市";
    self.supermarketLable.font = [UIFont fontWithName:nil size:14];
    
    
}




@end
