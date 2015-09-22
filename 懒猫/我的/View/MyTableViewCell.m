//
//  MyTableViewCell.m
//  懒猫
//
//  Created by jike on 15/9/15.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "MyTableViewCell.h"
#import "Base.h"
@implementation MyTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImg = [[UIImageView alloc] init];
        [self addSubview:self.headImg];
        
        self.titleLable = [[UILabel alloc] init];
        [self addSubview:self.titleLable];
        
        self.litleLable = [[UILabel alloc] init];
        [self addSubview:self.litleLable];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headImg.frame = CGRectMake(10, 10, 30, 30);
    
    self.titleLable.frame = CGRectMake(50, 15, 200, 20);
    
    self.litleLable.frame = CGRectMake(SCREEN_WIDTH - 180, 15, 150, 20);
    self.litleLable.font = [UIFont fontWithName:nil size:13];
    self.litleLable.textAlignment = NSTextAlignmentRight;
    self.litleLable.textColor = [UIColor grayColor];

}













- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
