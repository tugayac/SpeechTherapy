//
//  User.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/10/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSSet * supervising;

+ (User *)addUserWithUsername:(NSString *)username firstName:(NSString *)firstName lastName:(NSString *)lastName password:(NSString *)password imageFile:(NSString *)imageURL;
+ (NSArray *)getAllUsers;
+ (User *)getUser:(User *)user;

@end
