//
//  LeftTableCell.m
//  懒猫
//
//  Created by jike on 15/9/17.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "LeftTableCell.h"

@implementation LeftTableCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLable = [[UILabel alloc] init];
        [self addSubview:self.titleLable];
        
        self.leftView = [[UIView alloc] init];
        [self addSubview:self.leftView];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLable.frame = CGRectMake(0, 0, 115, 50);
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.textColor = [UIColor blackColor];
//    self.textLabel.text = @"aaafdf";
//    self.titleLable.backgroundColor = [UIColor whiteColor];
//    
    self.leftView.frame = CGRectMake(0, 0, 2, 50);
    self.leftView.backgroundColor = [UIColor orangeColor];
    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
