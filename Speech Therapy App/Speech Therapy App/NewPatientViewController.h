//
//  NewPatientViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModalFormViewController.h"
#import "AutoCompleteViewController.h"
#import "User.h"

@interface NewPatientViewController : ModalFormViewController<UIPopoverControllerDelegate, AutoCompleteViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *firstNameField;
@property (nonatomic, weak) IBOutlet UITextField *lastNameField;
@property (nonatomic, weak) IBOutlet UITextField *usernameField;
@property (nonatomic, weak) IBOutlet UITextField *typeOfAutismField;

@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) UIPopoverController *autoCompletePopover;
@property (nonatomic, strong) AutoCompleteViewController *acvc;

- (IBAction)usernameAvailabilityCheck:(id)sender;
- (IBAction)autoCompleteTypeOfAutismField:(id)sender;
- (IBAction)submitButtonClicked:(id)sender;

@end
