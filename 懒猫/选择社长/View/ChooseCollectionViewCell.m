//
//  ChooseCollectionViewCell.m
//  懒猫
//
//  Created by jike on 15/9/11.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "ChooseCollectionViewCell.h"
#import "Base.h"

@implementation ChooseCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[UIImageView alloc] init];
        [self addSubview:self.imgView];
        
        self.titleLable = [[UILabel alloc] init];
        [self addSubview:self.titleLable];
        
        self.freeLable = [[UILabel alloc] init];
        [self addSubview:self.freeLable];
        
        self.bendTime = [[UILabel alloc] init];
        [self addSubview:self.bendTime];
        
        self.distance = [[UILabel alloc] init];
        [self addSubview:self.distance];
        
        
        
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
     // 图片
    self.imgView.frame = CGRectMake(3, 3, layoutAttributes.size.width - 6, layoutAttributes.size.height - SCREEN_HEIGHT * 0.12);
    self.imgView.backgroundColor = [UIColor greenColor];
    
    // 标题
    self.titleLable.frame = CGRectMake(3, layoutAttributes.size.height - SCREEN_HEIGHT * 0.12 + 10, layoutAttributes.size.width - 6, 20);
    self.titleLable.font = [UIFont fontWithName:nil size:15];
//    self.titleLable.text = @"都会新峰懒猫社";
    self.titleLable.backgroundColor = [UIColor whiteColor];
    
    // 免费配送
    self.freeLable.frame = CGRectMake(3, layoutAttributes.size.height - SCREEN_HEIGHT * 0.12 + 35, 60, 20);
//    self.freeLable.text = @"免费配送";
    self.freeLable.font = [UIFont fontWithName:nil size:11];
    self.freeLable.textColor = [UIColor grayColor];
    self.freeLable.backgroundColor = [UIColor orangeColor];
    self.freeLable.textAlignment = NSTextAlignmentCenter;
    self.freeLable.layer.cornerRadius = 8;
    self.freeLable.clipsToBounds = YES;
    
    
    self.bendTime.frame = CGRectMake(3, layoutAttributes.size.height - 23, layoutAttributes.size.width - 50, 20);
    
//    self.bendTime.backgroundColor = [UIColor greenColor];
//    self.bendTime.text = @"营业时间:07:00-20:00";
    self.bendTime.font = [UIFont fontWithName:nil size:11];
    self.bendTime.textColor = [UIColor grayColor];
    
    
    self.distance.frame = CGRectMake(layoutAttributes.size.width - 65, layoutAttributes.size.height - 23, 60, 20);
//    self.distance.text = @"860m";
//    self.distance.backgroundColor = [UIColor blackColor];
    self.distance.font = [UIFont fontWithName:nil size:11];
    self.distance.textAlignment = NSTextAlignmentRight;
    self.distance.textColor = [UIColor grayColor];
    
    
}







@end
