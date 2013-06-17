//
//  Patient.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Patient : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) NSDate * lastTestDate;
@property (nonatomic, retain) NSString * typeOfAutism;
@property (nonatomic, retain) User *supervisedBy;

+ (Patient *)addPatientWithUsername:(NSString *)username firstName:(NSString *)firstName lastName:(NSString *)lastName typeOfAutism:(NSString *)typeOfAutism supervisor:(User *)user;
+ (NSArray *)getPatientsForUser:(User *)user;
+ (BOOL)removePatient:(NSManagedObject *)patient;

@end