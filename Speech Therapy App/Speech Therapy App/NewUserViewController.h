//
//  NewUserViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/11/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewUserViewControllerDelegate;

@interface NewUserViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, weak) id<NewUserViewControllerDelegate> delegate;

@property (nonatomic, weak) IBOutlet UITextField *usernameField;
@property (nonatomic, weak) IBOutlet UITextField *firstNameField;
@property (nonatomic, weak) IBOutlet UITextField *lastNameField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;
@property (nonatomic, weak) IBOutlet UITextField *passwordAgainField;

- (IBAction)checkTextFieldContentLength:(id)sender;
- (IBAction)usernameAvailabilityCheck:(id)sender;
- (IBAction)passwordValidityCheck:(id)sender;
- (IBAction)submitButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;

@end

@protocol NewUserViewControllerDelegate <NSObject>

@optional
- (void)newUserViewControllerSubmitButtonPressed:(NewUserViewController *)nuvc;

@end