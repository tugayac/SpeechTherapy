//
//  User.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/10/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "User.h"
#import "AppDelegate.h"

@implementation User

@dynamic firstName;
@dynamic lastName;
@dynamic username;
@dynamic password;
@dynamic imageURL;

+ (User *)addUserWithUsername:(NSString *)username firstName:(NSString *)firstName lastName:(NSString *)lastName password:(NSString *)password imageFile:(NSString *)imageURL;
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSArray *existingUsers = [self getAllUsers];
    for (User *user in existingUsers) {
        if ([user.username isEqualToString:username]) {
            return nil;
        }
    }
    
    User *user = (User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [user setUsername:username];
    [user setFirstName:firstName];
    [user setLastName:lastName];
    [user setPassword:password];
    [user setImageURL:imageURL];
    
    NSError *error = nil;
    if (![[appDelegate managedObjectContext] save:&error]) {
        // Handle the error
    }
    
    return user;
}

+ (NSArray *)getAllUsers
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[appDelegate managedObjectContext]];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchResults = [[appDelegate managedObjectContext] executeFetchRequest:request error:&error];
    if (fetchResults == nil) {
        return nil;
    } else {
        return fetchResults;
    }
}

@end
