//
//  NewUserViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/11/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "NewUserViewController.h"
#import "User.h"

@implementation NewUserViewController

@synthesize usernameField, firstNameField, lastNameField, passwordField, passwordAgainField;

- (id)init
{
    return [self initWithNibName:@"NewUserViewController" bundle:nil];
}

- (IBAction)usernameAvailabilityCheck:(id)sender
{
    NSArray *existingUsers = [User getAllUsers];
    for (User *user in existingUsers) {
        if ([user.username isEqualToString:self.usernameField.text]) {
            UIAlertView *usernameExistsAlert = [[UIAlertView alloc] initWithTitle:@"Unavailable Username" message:@"The username you have chosen already exists. Please choose another username." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [usernameExistsAlert setAlertViewStyle:UIAlertViewStyleDefault];
            [usernameExistsAlert show];
            
            [self.usernameField setText:@""];
            [self setTextFieldBorder:self.usernameField toColor:[UIColor redColor]];
            return;
        }
    }
    
    [self setTextFieldBorder:self.usernameField toColor:[UIColor greenColor]];
}

- (BOOL)checkIfPasswordsMatch
{
    if (![self.passwordField.text isEqualToString:self.passwordAgainField.text]) {
        UIAlertView *passwordMismatchAlert = [[UIAlertView alloc] initWithTitle:@"Password Mismatch" message:@"The passwords do not match. Please make sure you are entering the correct characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [passwordMismatchAlert setAlertViewStyle:UIAlertViewStyleDefault];
        [passwordMismatchAlert show];
        
        [self setTextFieldBorder:self.passwordAgainField toColor:[UIColor redColor]];
        
        return NO;
    } else {
        return YES;
    }
}

- (IBAction)submitButtonClicked:(id)sender
{
    if (![self checkIfPasswordsMatch]) {
        return;
    }
    
    if ([self text:self.firstNameField.text lengthLessThan:1] ||
        [self text:self.lastNameField.text lengthLessThan:1] ||
        [self text:self.usernameField.text lengthLessThan:1] ||
        [self text:self.passwordField.text lengthLessThan:1] ||
        [self text:self.passwordAgainField.text lengthLessThan:1]) {
        UIAlertView *invalidEntryAlert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"One or more of the fields are empty. Please fill in all the fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [invalidEntryAlert setAlertViewStyle:UIAlertViewStyleDefault];
        [invalidEntryAlert show];
    } else {
        [super submitButtonClicked:sender];
    }
}

@end
