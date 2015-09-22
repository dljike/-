//
//  RecommendCell.h
//  懒猫
//
//  Created by jike on 15/9/12.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendCell : UICollectionViewCell

@property (nonatomic, retain) UIImageView *imgView; // 图片
@property (nonatomic, retain) UILabel *titleLable; // 标题Lable
@property (nonatomic, retain) UILabel *weightLable; // 重量Lable
@property (nonatomic, retain) UILabel *nowMoneyLable; // 钱Lable
@property (nonatomic, retain) UILabel *beforeMoneyLable; // 原价
@property (nonatomic, retain) UIView *lineView;  // 原价删除线


// 加减数量
@property (nonatomic, retain) UILabel *count; //
@property (nonatomic, retain) UIButton *subtraction;
@property (nonatomic, retain) UIButton *addition;



@end
