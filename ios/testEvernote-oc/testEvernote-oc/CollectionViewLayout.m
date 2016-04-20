//
//  CollectionViewLayout.m
//  testEvernote-oc
//
//  Created by Dragonet on 16/4/20.
//  Copyright © 2016年 zhongqinglongtu. All rights reserved.
//

#import "CollectionViewLayout.h"

@implementation CollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 2 * 10, 45);
        self.headerReferenceSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 10);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.itemSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 2 * 10, 45);
        self.headerReferenceSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 10);
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attrsArray = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat offsetY = self.collectionView.contentOffset.y;
    CGFloat collectionViewFrameHeight = self.collectionView.frame.size.height;
    CGFloat collectionViewContentHeight = self.collectionView.contentSize.height;
    CGFloat scrollViewContentInsetBottom = self.collectionView.contentInset.bottom;
    CGFloat bottomOffset = offsetY + collectionViewFrameHeight - collectionViewContentHeight - scrollViewContentInsetBottom;
    NSInteger numOfItems = self.collectionView.numberOfSections;
    
    for (UICollectionViewLayoutAttributes *attr in attrsArray) {
        if (attr.representedElementCategory == UICollectionElementCategoryCell) {
            CGRect cellRect = attr.frame;
            if (offsetY <= 0) {
                CGFloat distance = fabs(offsetY) / 10;
                cellRect.origin.y += offsetY + distance * (attr.indexPath.section + 1);
            } else if (bottomOffset > 0) {
                CGFloat distance = bottomOffset / 10;
                cellRect.origin.y += bottomOffset - distance * (numOfItems - attr.indexPath.section);
            }
            
            attr.frame = cellRect;
        }
    }
    
    return attrsArray;
}

@end
