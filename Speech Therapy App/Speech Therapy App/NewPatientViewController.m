//
//  NewPatientViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "NewPatientViewController.h"
#import "AutoCompleteViewController.h"
#import "Patient.h"

@implementation NewPatientViewController

@synthesize currentUser;

- (id)init
{
    return [self initWithNibName:@"NewPatientViewController" bundle:nil];
}

- (IBAction)usernameAvailabilityCheck:(id)sender
{
    NSArray *existingPatients = [Patient getPatientsForUser:self.currentUser];
    for (Patient *patient in existingPatients) {
        if ([patient.username isEqualToString:self.usernameField.text]) {
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

- (IBAction)autoCompleteTypeOfAutismField:(id)sender
{
    if (!self.autoCompletePopover && !self.acvc) {
        UITextField *textField = (UITextField *) sender;
        
        self.acvc = [[AutoCompleteViewController alloc] init];
        self.acvc.delegate = self;
        
        self.autoCompletePopover = [[UIPopoverController alloc] initWithContentViewController:self.acvc];
        self.autoCompletePopover.delegate = self;
        [self.autoCompletePopover presentPopoverFromRect:textField.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        [self.acvc updateSuggestionsBasedOnInput:self.typeOfAutismField.text];
    } else {
        [self.acvc updateSuggestionsBasedOnInput:self.typeOfAutismField.text];
    }
}

- (IBAction)submitButtonClicked:(id)sender
{
    if ([self text:self.firstNameField.text lengthLessThan:1] ||
        [self text:self.lastNameField.text lengthLessThan:1] ||
        [self text:self.usernameField.text lengthLessThan:1] ||
        [self text:self.typeOfAutismField.text lengthLessThan:1]) {
        UIAlertView *invalidEntryAlert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"One or more of the fields are empty. Please fill in all the fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [invalidEntryAlert setAlertViewStyle:UIAlertViewStyleDefault];
        [invalidEntryAlert show];
    } else {
        [super submitButtonClicked:sender];
    }
}

- (void)autoCompleteSuggestionSelected:(NSString *)suggestion
{
    [self.typeOfAutismField setText:suggestion];
    [self.autoCompletePopover dismissPopoverAnimated:YES];
    [self popoverControllerDidDismissPopover:nil];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.autoCompletePopover = nil;
    self.acvc = nil;
}

@end
