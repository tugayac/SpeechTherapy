//
//  Patient.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "Patient.h"
#import "User.h"
#import "AppDelegate.h"

@implementation Patient

@dynamic username;
@dynamic firstName;
@dynamic lastName;
@dynamic dateAdded;
@dynamic lastTestDate;
@dynamic typeOfAutism;
@dynamic supervisedBy;

+ (Patient *)addPatientWithUsername:(NSString *)username firstName:(NSString *)firstName lastName:(NSString *)lastName typeOfAutism:(NSString *)typeOfAutism supervisor:(User *)user
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSArray *existingPatients = [self getPatientsForUser:user];
    for (Patient *patient in existingPatients) {
        if ([patient.username isEqualToString:username]) {
            return nil;
        }
    }
    
    Patient *patient = (Patient *)[NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [patient setFirstName:firstName];
    [patient setLastName:lastName];
    [patient setTypeOfAutism:typeOfAutism];
    [patient setSupervisedBy:user];
    
    [patient setDateAdded:[NSDate date]];
    [patient setLastTestDate:nil];
    
    User *existingUser = [User getUser:user];
    [existingUser setSupervising:patient];
    
    NSError *error = nil;
    if (![[appDelegate managedObjectContext] save:&error]) {
        // Handle the error
    }
    
    return patient;
}

+ (NSArray *)getPatientsForUser:(User *)user
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Patient" inManagedObjectContext:[appDelegate managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"supervisedBy.username like '%@'", user.username]];
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

@end
