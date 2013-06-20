//
//  TestCellBackground.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/20/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "TestCellBackground.h"

@implementation TestCellBackground

- (void)drawRect:(CGRect)rect
{
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0f];
    [bezierPath setLineWidth:5.0f];
    [[UIColor blackColor] setStroke];
    
    UIColor *fillColor = [UIColor colorWithRed:0.529 green:0.808 blue:0.922 alpha:1.0f];
    [fillColor setFill];
    
    [bezierPath stroke];
    [bezierPath fill];
    CGContextRestoreGState(aRef);
}

@end
