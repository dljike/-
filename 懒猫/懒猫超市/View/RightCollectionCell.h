//
//  RightCollectionCell.h
//  懒猫
//
//  Created by jike on 15/9/17.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightCollectionCell : UICollectionViewCell


@property (nonatomic, retain) UIImageView *imgView;
@property (nonatomic, retain) UILabel *titleLable;
@property (nonatomic, retain) UILabel *tagLable;
@property (nonatomic, retain) UILabel *nowMoney;
@property (nonatomic, retain) UILabel *beforeMoney;
@property (nonatomic, retain) UIView *lineView;
@property (nonatomic, retain) UIView *cellView;


// 加减数量
@property (nonatomic, retain) UILabel *count; //
@property (nonatomic, retain) UIButton *subtraction;
@property (nonatomic, retain) UIButton *addition;

@property (nonatomic, retain) UILabel *nullProduct;

@end
