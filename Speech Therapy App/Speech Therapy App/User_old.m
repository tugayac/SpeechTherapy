//
//  User.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/10/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic username, firstName, lastName, imageURL;

- (id)initWithUsername:(NSString *)newUsername firstName:(NSString *)newFirstName lastName:(NSString *)newLastName
{
    self = [super init];
    if (self)
    {
        self.username = newUsername;
        self.firstName = newFirstName;
        self.lastName = newLastName;
        self.imageURL = @"User.png";
    }
    return self;
}

@end
