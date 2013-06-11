//
//  UserViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/10/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "UserViewController.h"
#import "User.h"
#import "UserCell.h"
#import "AppDelegate.h"

@implementation UserViewController

@synthesize userCollection, users, managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.users = [[NSMutableArray alloc] init];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    [self addUserWithUsername:@"Add User" firstName:@"Add" lastName:@"User" imageFile:@"PlusSign.png"];
    
    // Create Dummy User for testing
    [self addUserWithUsername:@"dummyuser" firstName:@"Dummy" lastName:@"User" imageFile:@"User.png"];
    [self.userCollection reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return ceil([self.users count] / 3.0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.users count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UserCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserCell" forIndexPath:indexPath];
    
    User *user = [self.users objectAtIndex:[indexPath row]];
    
    cell.userLabel.text = [user username];
    cell.userImage.image = [UIImage imageNamed:[user imageURL]];
    
    return cell;
}

- (void)addUserWithUsername:(NSString *)username firstName:(NSString *)firstName lastName:(NSString *)lastName imageFile:(NSString *)imageURL
{    
    User *user = (User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
    
    [user setUsername:username];
    [user setFirstName:firstName];
    [user setLastName:lastName];
    [user setImageURL:imageURL];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error
    }

    [users insertObject:user atIndex:0];
}

@end
