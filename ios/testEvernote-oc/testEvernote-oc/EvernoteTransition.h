//
//  EvernoteTransition.h
//  testEvernote-oc
//
//  Created by Dragonet on 16/4/21.
//  Copyright © 2016年 zhongqinglongtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteViewController.h"
#import "CollectionViewCell.h"

@interface EvernoteTransition : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate, NoteViewControllerDelegate>

@property (assign, nonatomic) BOOL isPresent;
@property (strong, nonatomic) CollectionViewCell* selectCell;
@property (strong, nonatomic) NSArray *visibleCells;
@property (assign, nonatomic) CGRect originFrame;
@property (assign, nonatomic) CGRect finalFrame;
@property (strong, nonatomic) UIViewController *panViewController;
@property (strong, nonatomic) UIViewController *listViewController;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactiveController;

- (void)evernoteTransitionWithSelectCell:(CollectionViewCell *)cell visibleCells:(NSArray *)visibleCells originFrame:(CGRect)originFrame finalFrame:(CGRect)finalFrame panViewController:(UIViewController *)panViewController listViewController:(UIViewController *)listViewController;

@end
