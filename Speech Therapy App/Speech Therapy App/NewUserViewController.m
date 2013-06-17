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

- (IBAction)checkTextFieldContentLength:(id)sender
{
    UITextField *textField = (UITextField *) sender;
    if (textField.text.length < 1) {
        [self setTextFieldBorder:textField toColor:[UIColor redColor]];
    } else {
        [self setTextFieldBorder:textField toColor:[UIColor greenColor]];
    }
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

- (IBAction)passwordValidityCheck:(id)sender
{
    if (![self.passwordField.text isEqualToString:self.passwordAgainField.text]) {
        UIAlertView *passwordMismatchAlert = [[UIAlertView alloc] initWithTitle:@"Password Mismatch" message:@"The passwords do not match. Please make sure you are entering the correct characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [passwordMismatchAlert setAlertViewStyle:UIAlertViewStyleDefault];
        [passwordMismatchAlert show];
        
        [self setTextFieldBorder:self.passwordAgainField toColor:[UIColor redColor]];
    }
}

@end
