//
//  User.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/10/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface User : NSManagedObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *imageURL;

- (id)initWithUsername:(NSString *)newUsername firstName:(NSString *)newFirstName lastName:(NSString *)newLastName;

@end
