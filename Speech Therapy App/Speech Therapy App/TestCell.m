//
//  TestCell.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/20/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "TestCell.h"
#import "TestCellBackground.h"

@implementation TestCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        TestCellBackground* backgroundView = [[TestCellBackground alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView = backgroundView;
    }
    return self;
}

@end
