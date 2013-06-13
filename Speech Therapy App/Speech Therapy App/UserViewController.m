//
//  UserViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/10/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "UserViewController.h"
#import "RecordingsViewController.h"
#import "User.h"
#import "UserCell.h"
#import "AppDelegate.h"
#import "ViewConstants.h"

@implementation UserViewController

@synthesize userCollection, users;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.users = [[NSMutableArray alloc] init];

    self.users = [[User getAllUsers] mutableCopy];
    
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
    UserCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kUserCellIdentifier forIndexPath:indexPath];
    
    User *user = [self.users objectAtIndex:[indexPath row]];
    
    cell.userLabel.text = [user username];
    cell.userImage.image = [UIImage imageNamed:[user imageURL]];
    
    return cell;
}

- (IBAction)addNewUser:(id)sender
{
    NewUserViewController *newUserViewController = [[NewUserViewController alloc] init];
    newUserViewController.delegate = self; // Set delegation
    CGRect xibBounds = newUserViewController.view.bounds;
    [newUserViewController setModalPresentationStyle:UIModalPresentationFormSheet];
    [newUserViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:newUserViewController animated:YES completion:nil];
    
    newUserViewController.view.superview.bounds = xibBounds; // Change size of form sheet
    newUserViewController.view.superview.center = self.view.center;
}

- (void)newUserViewControllerSubmitButtonPressed:(NewUserViewController *)nuvc
{
    User *user = [User addUserWithUsername:nuvc.usernameField.text firstName:nuvc.firstNameField.text lastName:nuvc.lastNameField.text password:nuvc.passwordField.text imageFile:kUserImageURL];
    [self.users insertObject:user atIndex:0];
    [self.userCollection reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kUserLoggedIn]) {
        RecordingsViewController *recordingsViewController = segue.destinationViewController;
    }
}

@end
