//
//  CollectionViewCell.m
//  testEvernote-oc
//
//  Created by zxl on 16/4/20.
//  Copyright © 2016年 zhongqinglongtu. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()
@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0;
    if (self.titleLabel) {
        self.horizonallyCons = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    }
}

@end
