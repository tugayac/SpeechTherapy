//
//  CollectionViewLayoutAttributes.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/20/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "UserCollectionViewLayoutAttributes.h"

@implementation UserCollectionViewLayoutAttributes

- (id)copyWithZone:(NSZone *)zone
{
    UserCollectionViewLayoutAttributes *attributes = [super copyWithZone:zone];
    attributes.deleteButtonHidden = _deleteButtonHidden;
    return attributes;
}

@end
