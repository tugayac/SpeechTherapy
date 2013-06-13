//
//  NewPatientViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewPatientViewControllerDelegate;

@interface NewPatientViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, weak) id<NewPatientViewControllerDelegate> delegate;

@property (nonatomic, weak) IBOutlet UITextField *firstNameField;
@property (nonatomic, weak) IBOutlet UITextField *lastNameField;
@property (nonatomic, weak) IBOutlet UITextField *usernameField;
@property (nonatomic, weak) IBOutlet UITextField *typeOfAutismField;

- (IBAction)checkTextFieldContentLength:(id)sender;
- (IBAction)usernameAvailabilityCheck:(id)sender;
- (IBAction)submitButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;

@end

@protocol NewPatientViewControllerDelegate <NSObject>

@optional
- (void)newPatientViewControllerSubmitButtonPressed:(NewPatientViewController *)npvc;

@end
