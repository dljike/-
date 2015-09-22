//
//  ImageCell.m
//  懒猫
//
//  Created by jike on 15/9/12.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.img = [[UIImageView alloc] init];
        [self addSubview:self.img];
    }
    return self;
}



-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.img.frame = CGRectMake(0, 0,layoutAttributes.size.width, layoutAttributes.size.height);
    
    
}



@end
