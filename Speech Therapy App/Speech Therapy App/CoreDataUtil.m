//
//  CoreDataUtil.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/14/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "CoreDataUtil.h"
#import "AppDelegate.h"

@implementation CoreDataUtil

+ (BOOL)deleteObject:(NSManagedObject *)object
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
   
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    [context deleteObject:object];
    
    NSError *error = nil;
    if (![context save:&error]) {
        return NO;
    }
    return YES;
}

@end
