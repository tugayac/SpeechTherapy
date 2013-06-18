//
//  Test.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/17/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Test : NSManagedObject

@property (nonatomic, retain) NSDate * dateCompleted;
@property (nonatomic, retain) NSDate * dateStarted;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * resultsPath;
@property (nonatomic, retain) NSString * testName;
@property (nonatomic, retain) NSNumber * timeTaken;
@property (nonatomic, retain) Patient *takenBy;

+ (Test *)addNewResultForTest:(NSString *)testName takenBy:(Patient *)patient startingOn:(NSDate *)start endingOn:(NSDate *)end withResult:(NSString *)atPath withNotes:(NSString *)notes;
+ (NSArray *)getTestsForPatient:(Patient *)patient;
+ (NSString *)dateToString:(NSDate *)date withFormat:(NSDateFormatterStyle)format;
+ (BOOL)removeTest:(NSManagedObject *)test;

@end
