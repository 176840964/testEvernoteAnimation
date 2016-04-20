//
//  EvernoteTransition.m
//  testEvernote-oc
//
//  Created by Dragonet on 16/4/21.
//  Copyright © 2016年 zhongqinglongtu. All rights reserved.
//

#import "EvernoteTransition.h"

@implementation EvernoteTransition

- (void)evernoteTransitionWithSelectCell:(CollectionViewCell *)cell visibleCells:(NSArray *)visibleCells originFrame:(CGRect)originFrame finalFrame:(CGRect)finalFrame panViewController:(UIViewController *)panViewController listViewController:(UIViewController *)listViewController {
    self.selectCell = cell;
    self.visibleCells = visibleCells;
    self.originFrame = originFrame;
    self.finalFrame = finalFrame;
    self.panViewController = panViewController;
    self.listViewController = listViewController;
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    pan.edges = UIRectEdgeLeft;
    [self.panViewController.view addGestureRecognizer:pan];
    
    if (!self.interactiveController) {
        self.interactiveController = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
}

#pragma mark - 
- (void)handlePanGesture:(UIScreenEdgePanGestureRecognizer*)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self.panViewController dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self.panViewController.view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(self.panViewController.view.bounds));
        [self.interactiveController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:self.panViewController.view].x > 0) {
            [self finishInteractive];
        } else {
            [self.interactiveController cancelInteractiveTransition];
            [self.listViewController presentViewController:self.panViewController animated:NO completion:^{
                
            }];
        }
    }
}

- (void)finishInteractive {
    [self.interactiveController finishInteractiveTransition];
    self.selectCell.textView.scrollEnabled = YES;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.45;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *nextVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [transitionContext containerView].backgroundColor = [UIColor colorWithRed:56 / 255.0 green:51 / 255.0 blue:76 / 255.0 alpha:1.0];
    self.selectCell.frame = self.isPresent ? self.originFrame : self.finalFrame;
    
    UIView *addView = nextVC.view;
    addView.hidden = self.isPresent;
    [[transitionContext containerView] addSubview:addView];
    
    NSLayoutConstraint *removeCons = self.isPresent ? self.selectCell.lableLeadCons : self.selectCell.horizonallyCons;
    NSLayoutConstraint *addCons = self.isPresent ? self.selectCell.horizonallyCons : self.selectCell.lableLeadCons;
    [self.selectCell removeConstraint:removeCons];
    [self.selectCell addConstraint:addCons];
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (CollectionViewCell * cell in self.visibleCells) {
            if (cell != self.selectCell) {
                CGRect frame = cell.frame;
                if (cell.tag < self.selectCell.tag) {
                    CGFloat yDistance = self.originFrame.origin.y - self.finalFrame.origin.y + 30;
                    CGFloat yUpdate = self.isPresent ? yDistance : -yDistance;
                    frame.origin.y -= yUpdate;
                } else if (cell.tag > self.selectCell.tag) {
                    CGFloat yDistance = CGRectGetMaxY(self.finalFrame) - CGRectGetMaxY(self.originFrame) + 30;
                    CGFloat yUpdate = self.isPresent ? yDistance : -yDistance;
                    frame.origin.y += yUpdate;
                }
                cell.frame = frame;
                cell.transform = self.isPresent ? CGAffineTransformMakeScale(0.8, 1.0) : CGAffineTransformIdentity;
            }
        }
        self.selectCell.backButton.alpha = self.isPresent ? 1.0 : 0.0;
        self.selectCell.titleLine.alpha = self.isPresent ? 1.0 : 0.0;
        self.selectCell.textView.alpha = self.isPresent ? 1.0 : 0.0;
        self.selectCell.frame = self.isPresent ? self.finalFrame : self.originFrame;
        [self.selectCell layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        addView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresent = YES;
    self.selectCell.textView.scrollEnabled = NO;
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresent = NO;
    return self;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveController;
}

#pragma mark - NoteViewControllerDelegate
- (void)didClickGoBack {
    [self finishInteractive];
}

@end
