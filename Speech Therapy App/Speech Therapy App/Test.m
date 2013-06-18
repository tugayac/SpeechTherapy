//
//  Test.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/17/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "Test.h"
#import "Patient.h"
#import "AppDelegate.h"

@implementation Test

@dynamic dateCompleted;
@dynamic dateStarted;
@dynamic notes;
@dynamic resultsPath;
@dynamic testName;
@dynamic timeTaken;
@dynamic takenBy;

+ (Test *)addNewResultForTest:(NSString *)testName takenBy:(Patient *)patient startingOn:(NSDate *)start endingOn:(NSDate *)end withResult:(NSString *)atPath withNotes:(NSString *)notes
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    Test *test = (Test *)[NSEntityDescription insertNewObjectForEntityForName:@"Test" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [test setDateStarted:start];
    [test setDateCompleted:end];
    [test setTimeTaken:[NSNumber numberWithDouble:[start timeIntervalSinceDate:end]]];
    [test setTestName:testName];
    [test setNotes:notes];
    [test setResultsPath:atPath];
    [test setTakenBy:patient];
    
    NSError *error = nil;
    if (![[appDelegate managedObjectContext] save:&error]) {
        // Handle the error
    }
    
    return test;
}

+ (NSArray *)getTestsForPatient:(Patient *)patient
{
    if (patient == nil) {
        return nil;
    }
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test" inManagedObjectContext:[appDelegate managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"takenBy.username like '%@'", patient.username]];
    [request setPredicate:predicate];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchResults = [[appDelegate managedObjectContext] executeFetchRequest:request error:&error];
    if (fetchResults == nil) {
        return nil;
    } else {
        return fetchResults;
    }
}

+ (NSString *)dateToString:(NSDate *)date withFormat:(NSDateFormatterStyle)format
{
    return [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:format];
}

+ (BOOL)removeTest:(NSManagedObject *)test
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    [context deleteObject:test];
    
    NSError *error = nil;
    if (![context save:&error]) {
        return NO;
    }
    return YES;
}

@end
