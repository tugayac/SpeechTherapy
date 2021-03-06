//
//  UserCell.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/10/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserCollectionViewLayoutAttributes.h"

@interface UserCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView *userImage;
@property (nonatomic, strong) IBOutlet UILabel *userLabel;
@property (nonatomic, strong) UIButton *deleteButton;

- (void)applyLayoutAttributes:(UserCollectionViewLayoutAttributes *)layoutAttributes;

@end
