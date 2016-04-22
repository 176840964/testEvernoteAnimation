//
//  CollectionViewCell.h
//  testEvernote-oc
//
//  Created by zxl on 16/4/20.
//  Copyright © 2016年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *titleLine;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lableLeadCons;

@property (strong, nonatomic) NSLayoutConstraint *horizonallyCons;

@end
