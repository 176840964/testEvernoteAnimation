//
//  CollectionViewCell.m
//  testEvernote-oc
//
//  Created by zxl on 16/4/20.
//  Copyright © 2016年 zhongqinglongtu. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *titleLine;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableLeadCons;

@property (strong, nonatomic) NSLayoutConstraint *horizonallyCons;
@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
