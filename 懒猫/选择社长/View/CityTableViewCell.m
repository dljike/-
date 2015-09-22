//
//  CityTableViewCell.m
//  懒猫
//
//  Created by jike on 15/9/15.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "CityTableViewCell.h"
#import "Base.h"
@implementation CityTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cityLable = [[UILabel alloc] init];
        [self addSubview:self.cityLable];

       
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.cityLable.frame = CGRectMake(0, 10, 110, 30);
    self.cityLable.textAlignment = NSTextAlignmentCenter;
    
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
