//
//  NoteViewController.h
//  testEvernote-oc
//
//  Created by Dragonet on 16/4/21.
//  Copyright © 2016年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoteViewControllerDelegate;

@interface NoteViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *totalView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) UIColor *domainColor;
@property (copy, nonatomic) NSString *titleName;

@property (weak, nonatomic) id<NoteViewControllerDelegate> delegate;

@end

@protocol NoteViewControllerDelegate <NSObject>

- (void)didClickGoBack;

@end