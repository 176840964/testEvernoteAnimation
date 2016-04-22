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
    
    NSMutableArray *arr = [NSMutableArray new];
    
    for (UICollectionViewLayoutAttributes *attr in attrsArray) {
        if (attr.representedElementCategory == UICollectionElementCategoryCell) {
            //修改属性，需要进行copy，否则会在log中报错（This is likely occurring because the flow layout subclass CollectionViewLayout is modifying attributes returned by UICollectionViewFlowLayout without copying them）
            UICollectionViewLayoutAttributes *attrCopy = [attr copy];
            CGRect cellRect = attrCopy.frame;
            if (offsetY <= 0) {
                CGFloat distance = fabs(offsetY) / 10;
                cellRect.origin.y += offsetY + distance * (attrCopy.indexPath.section + 1);
            } else if (bottomOffset > 0) {
                CGFloat distance = bottomOffset / 10;
                cellRect.origin.y += bottomOffset - distance * (numOfItems - attrCopy.indexPath.section);
            }
            
            attrCopy.frame = cellRect;
            [arr addObject:attrCopy];
        } else {
            [arr addObject:attr];
        }
        
    }
    
    return arr;
}

@end
