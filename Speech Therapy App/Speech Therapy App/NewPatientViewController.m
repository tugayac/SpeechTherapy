//
//  NewPatientViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "NewPatientViewController.h"
#import "Patient.h"

@implementation NewPatientViewController

- (id)init
{
    return [self initWithNibName:@"NewPatientViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

@end
