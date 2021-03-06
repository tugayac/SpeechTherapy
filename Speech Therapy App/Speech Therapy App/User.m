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
@dynamic supervising;

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
    [user setSupervising:nil];
    
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

+ (User *)getUser:(User *)user
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[appDelegate managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"username like '%@'", user.username]];
    [request setPredicate:predicate];
    [request setEntity:entity];
    
    NSError *error = nil;
    User *fetchResult = [[[appDelegate managedObjectContext] executeFetchRequest:request error:&error] objectAtIndex:0];
    if (fetchResult == nil) {
        return nil;
    } else {
        return fetchResult;
    }
}

+ (BOOL)removeUser:(NSManagedObject *)user
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    [context deleteObject:user];
    
    NSError *error = nil;
    if (![context save:&error]) {
        return NO;
    }
    return YES;
}

@end
