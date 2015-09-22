//
//  LoginTableViewCell.m
//  懒猫
//
//  Created by jike on 15/9/14.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "LoginTableViewCell.h"

@implementation LoginTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headerImg = [[UIImageView alloc] init];
        [self addSubview:self.headerImg];
        
        self.loginLable = [[UILabel alloc] init];
        [self addSubview:self.loginLable];
    }
    return self;
}




-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.headerImg.frame = CGRectMake(20, 10, 60, 60);
//    self.headerImg.layer.cornerRadius = 15;
    self.headerImg.backgroundColor = [UIColor greenColor];
    
    self.loginLable.frame = CGRectMake(100, 30, 200, 20);
    self.loginLable.textColor = [UIColor grayColor];
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
