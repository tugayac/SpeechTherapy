//
//  CollectionViewLayout.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/20/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "UserCollectionViewLayout.h"
#import "UserCollectionViewLayoutAttributes.h"

@implementation UserCollectionViewLayout

- (id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(175, 215);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(10, 75, 50, 75);
    }
    return self;
}

- (BOOL)isDeletionModeOn
{
    if ([[self.collectionView.delegate class] conformsToProtocol:@protocol(CollectionViewLayoutDelegate)]) {
        return [(id)self.collectionView.delegate isDeletionModeActiveForCollectionView:self.collectionView layout:self];
    } else {
        return NO;
    }
}

+ (Class)layoutAttributesClass
{
    return [UserCollectionViewLayoutAttributes class];
}

- (void)hideDeleteButtonIfDeletionModeActive:(UserCollectionViewLayoutAttributes *)attributes
{
    if ([self isDeletionModeOn]) {
        attributes.deleteButtonHidden = NO;
    } else {
        attributes.deleteButtonHidden = YES;
    }
}

- (UserCollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UserCollectionViewLayoutAttributes *attributes = (UserCollectionViewLayoutAttributes *) [super layoutAttributesForItemAtIndexPath:indexPath];
    [self hideDeleteButtonIfDeletionModeActive:attributes];
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArrayInRect = [super layoutAttributesForElementsInRect:rect];
    
    for (UserCollectionViewLayoutAttributes *attributes in attributesArrayInRect) {
        [self hideDeleteButtonIfDeletionModeActive:attributes];
    }
    return attributesArrayInRect;
}

@end
