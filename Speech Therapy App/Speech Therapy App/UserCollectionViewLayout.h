//
//  CollectionViewLayout.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/20/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewLayoutDelegate;

@interface UserCollectionViewLayout : UICollectionViewFlowLayout

@end

@protocol CollectionViewLayoutDelegate <UICollectionViewDelegateFlowLayout>

@required
-(BOOL)isDeletionModeActiveForCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout;

@end