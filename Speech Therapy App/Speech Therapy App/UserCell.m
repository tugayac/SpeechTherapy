//
//  UserCell.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/10/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UserCell.h"
#import "UserCellBackground.h"

@implementation UserCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UserCellBackground* backgroundView = [[UserCellBackground alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView = backgroundView;
        
        UIImage *deleteImage = [UIImage imageNamed:@"DeleteIcon.png"];
        self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, deleteImage.size.width, deleteImage.size.height)];
        [self.deleteButton setImage:deleteImage forState:UIControlStateNormal];
        [self.contentView addSubview:self.deleteButton];
    }
    return self;
}

- (void)applyLayoutAttributes:(UserCollectionViewLayoutAttributes *)layoutAttributes
{
    if (layoutAttributes.isDeleteButtonHidden) {
        self.deleteButton.layer.opacity = 0.0;
        [self stopQuivering];
    } else {
        self.deleteButton.layer.opacity = 1.0;
        [self startQuivering];
    }
}

- (void)startQuivering
{
    CABasicAnimation *quiverAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    float startAngle = (-2) * M_PI/180.0;
    float stopAngle = -startAngle;
    quiverAnim.fromValue = [NSNumber numberWithFloat:startAngle];
    quiverAnim.toValue = [NSNumber numberWithFloat:3 * stopAngle];
    quiverAnim.autoreverses = YES;
    quiverAnim.duration = 0.2;
    quiverAnim.repeatCount = HUGE_VALF;
    float timeOffset = (float)(arc4random() % 100)/100 - 0.50;
    quiverAnim.timeOffset = timeOffset;
    CALayer *layer = self.layer;
    [layer addAnimation:quiverAnim forKey:@"quivering"];
}

- (void)stopQuivering
{
    CALayer *layer = self.layer;
    [layer removeAnimationForKey:@"quivering"];
}

@end
