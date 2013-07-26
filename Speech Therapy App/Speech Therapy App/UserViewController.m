//
//  UserViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/10/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "UserViewController.h"
#import "RecordingsViewController.h"
#import "NewUserViewController.h"
#import "UserCell.h"
#import "AppDelegate.h"
#import "ViewConstants.h"

@interface UserViewController ()

@property (nonatomic) BOOL deletionModeEnabled;

@end

@implementation UserViewController

@synthesize userCollection, users, deletionModeEnabled;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILongPressGestureRecognizer *enterDeletionModeGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(enterDeletionMode:)];
    enterDeletionModeGesture.delegate = self;
    [self.userCollection addGestureRecognizer:enterDeletionModeGesture];
    UITapGestureRecognizer *exitDeletionModeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitDeletionMode:)];
    exitDeletionModeGesture.delegate = self;
    [self.userCollection addGestureRecognizer:exitDeletionModeGesture];
    
    self.users = [[NSMutableArray alloc] init];
    self.users = [[User getAllUsers] mutableCopy];
    
    UserCollectionViewLayout *cvl = [[UserCollectionViewLayout alloc] init];
    [self.userCollection setCollectionViewLayout:cvl];
    [self.userCollection reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.users count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kUserCellIdentifier forIndexPath:indexPath];
    
    User *user = [self.users objectAtIndex:[indexPath row]];
    
    cell.userLabel.text = [user username];
    cell.userImage.image = [UIImage imageNamed:[user imageURL]];
    
    [cell.deleteButton addTarget:self action:@selector(removeUser:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedUser = [self.users objectAtIndex:[indexPath row]];
    
    UIAlertView *passwordPrompt = [[UIAlertView alloc] initWithTitle:@"Password" message:@"Please enter your password:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [passwordPrompt setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    [passwordPrompt show];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.deletionModeEnabled) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)isDeletionModeActiveForCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
{
    return self.deletionModeEnabled;
}

- (void)removeUser:(UIButton *)button
{
    NSIndexPath *indexPath = [self.userCollection indexPathForCell:(UserCell *)button.superview.superview];
    [User removeUser:[self.users objectAtIndex:[indexPath row]]];
    [self.users removeObjectAtIndex:[indexPath row]];
    [self.userCollection deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
}

- (void)enterDeletionMode:(UILongPressGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath = [self.userCollection indexPathForItemAtPoint:[gr locationInView:self.userCollection]];
        if (indexPath) {
            self.deletionModeEnabled = YES;
            UserCollectionViewLayout *layout = (UserCollectionViewLayout *) self.userCollection.collectionViewLayout;
            [layout invalidateLayout];
        }
    }
}

- (void)exitDeletionMode:(UITapGestureRecognizer *)gr
{
    if (self.deletionModeEnabled) {
        NSIndexPath *indexPath = [self.userCollection indexPathForItemAtPoint:[gr locationInView:self.userCollection]];
        if (!indexPath) {
            self.deletionModeEnabled = NO;
            UserCollectionViewLayout *layout = (UserCollectionViewLayout *) self.userCollection.collectionViewLayout;
            [layout invalidateLayout];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPoint = [touch locationInView:self.userCollection];
    NSIndexPath *indexPath = [self.userCollection indexPathForItemAtPoint:touchPoint];
    if (indexPath && [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Password"]) {
        if (buttonIndex == 1) {
            NSString *password = [[alertView textFieldAtIndex:0] text];
            if ([password isEqualToString:self.selectedUser.password]) {
                [self performSegueWithIdentifier:kUserLoggedIn sender:self];
            } else {
                UIAlertView *wrongPassword = [[UIAlertView alloc] initWithTitle:@"Invalid Password"
                                                                message:@"The password does not match the username"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [wrongPassword setAlertViewStyle:UIAlertViewStyleDefault];
                [wrongPassword show];
            }
        }
    } else if ([alertView.title isEqualToString:@"Remove User"]) {
        if (buttonIndex == 1) {
            [User removeUser:self.selectedUser];
            [self.users removeObject:self.selectedUser];
            [self.userCollection reloadData];
        }
    }
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

- (void)modalFormViewControllerSubmitButtonTouched:(ModalFormViewController *)mfvc
{
    NewUserViewController *nuvc = (NewUserViewController *) mfvc;
    User *user = [User addUserWithUsername:nuvc.usernameField.text firstName:nuvc.firstNameField.text lastName:nuvc.lastNameField.text password:nuvc.passwordField.text imageFile:kUserImageURL];
    [self.users insertObject:user atIndex:0];
    [self.userCollection reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kUserLoggedIn]) {
        RecordingsViewController *recordingsViewController = segue.destinationViewController;
        recordingsViewController.currentUser = self.selectedUser;
    }
}

@end
