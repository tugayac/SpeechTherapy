//
//  NewUserViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/11/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "NewUserViewController.h"

@implementation NewUserViewController

@synthesize usernameField, firstNameField, lastNameField, passwordField, passwordAgainField;

- (id)init
{
    return [self initWithNibName:@"NewUserViewController" bundle:nil];
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
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)submitButtonClicked:(id)sender
{
    
}

- (IBAction)cancelButtonClicked:(id)sender
{
    
}

@end
