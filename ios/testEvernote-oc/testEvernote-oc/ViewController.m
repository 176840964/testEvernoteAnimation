//
//  ViewController.m
//  testEvernote-oc
//
//  Created by zxl on 16/4/20.
//  Copyright © 2016年 zhongqinglongtu. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "NoteViewController.h"
#import "EvernoteTransition.h"
#import "CollectionViewLayout.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property(weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (assign, nonatomic) NSInteger rowNumber;
@property (strong, nonatomic) NSMutableArray *colorArray;
@property (strong, nonatomic) NSIndexPath *selectIndexPath;
@property (strong, nonatomic) EvernoteTransition *customTransition;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.customTransition = [[EvernoteTransition alloc] init];
    self.colorArray = [NSMutableArray new];
    
    self.view.backgroundColor = [UIColor colorWithRed:56 / 255.0 green:51 / 255.0 blue:76 / 255.0 alpha:1.0];
    self.collectionView.backgroundColor = [UIColor colorWithRed:56 / 255.0 green:51 / 255.0 blue:76 / 255.0 alpha:1.0];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    self.rowNumber = 20;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    NSInteger readom = arc4random() % 360;
    for (NSInteger index = 0; index < self.rowNumber; index ++) {
        UIColor *color = [UIColor colorWithHue:((int)(readom + index * 6) % 360 / 360.0) saturation:0.8 brightness:1.0 alpha:1.0];
        [self.colorArray addObject:color];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PresentNoteViewController"]) {
        CollectionViewCell *cell = (CollectionViewCell*)[self.collectionView cellForItemAtIndexPath:self.selectIndexPath];
        NSArray *visibleCells = [self.collectionView visibleCells];
        
        NoteViewController *vc = segue.destinationViewController;
        vc.titleName = cell.titleLabel.text;
        vc.domainColor = cell.backgroundColor;
        
        CGRect finalFrame = CGRectMake(10, self.collectionView.contentOffset.y + 10, CGRectGetWidth([UIScreen mainScreen].bounds) - 20, CGRectGetHeight([UIScreen mainScreen].bounds) - 40);
        
        [self.customTransition evernoteTransitionWithSelectCell:cell visibleCells:visibleCells originFrame:cell.frame finalFrame:finalFrame panViewController:vc listViewController:self];
        vc.transitioningDelegate = self.customTransition;
        vc.delegate = self.customTransition;
    }
}
 

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.rowNumber;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [self.colorArray objectAtIndex:self.colorArray.count - 1 - indexPath.section];
    cell.titleLabel.text = [NSString stringWithFormat:@"cell %zd", indexPath.section];
    cell.backButton.alpha = 0;
    cell.textView.alpha = 0;
    cell.titleLine.alpha = 0;
    cell.tag = indexPath.section;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndexPath = indexPath;
    [self performSegueWithIdentifier:@"PresentNoteViewController" sender:self];
    
//    CollectionViewCell *cell = (CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
//    NSArray *visibleCells = [self.collectionView visibleCells];
//    
//    NoteViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteViewController"];
//    vc.titleName = cell.titleLabel.text;
//    vc.domainColor = cell.backgroundColor;
//    
//    CGRect finalFrame = CGRectMake(10, self.collectionView.contentOffset.y + 10, CGRectGetWidth([UIScreen mainScreen].bounds) - 20, CGRectGetHeight([UIScreen mainScreen].bounds) - 40);
//    
//    [self.customTransition evernoteTransitionWithSelectCell:cell visibleCells:visibleCells originFrame:cell.frame finalFrame:finalFrame panViewController:vc listViewController:self];
//    vc.transitioningDelegate = self.customTransition;
//    vc.delegate = self.customTransition;
//    
//    [self presentViewController:vc animated:YES completion:^{
//        
//    }];
}

@end
